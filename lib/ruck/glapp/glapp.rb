
module Ruck
  module GLApp
    
    class GLAppShreduler < Shreduler
      def initialize
        @shred_queues = {}
        [:frame,
         :key_down, :key_up,
         :mouse_down, :mouse_up, :mouse_move].each do |q|
          @shred_queues[q] = []
        end
        super
      end

      def starting
        @start_time = Time.now
      end

      def actual_now
        Time.now - @start_time
      end

      def sleep_current_til(queue)
        shred = current_shred
        @shreds.delete(shred)
        @shred_queues[queue] << shred
        shred.yield(0)

        @ev
      end

      def raise_event(ev, queue)
        # should use actual_now,
        # but we don't want to put it into the future
        new_now = actual_now
        new_now = [new_now, next_shred.now].min if next_shred
        @now = new_now

        @ev = ev # returned by sleep_current_til

        shreds = @shred_queues[queue]
        @shred_queues[queue] = []

        shreds.each do |shred|
          shred.now = new_now
          @shreds << shred
          invoke_shred shred
        end
      end

      def catch_up
        while shreds.length > 0 && next_shred.now < actual_now
          run_one
        end
      end
    end
    
    # stuff accessible in a shred
    module ShredLocal
      def spork(name = "unnamed", &shred)
        SHREDULER.spork(name, &shred)
      end

      def wait(seconds)
        SHREDULER.current_shred.yield(seconds)
      end

      [:frame, :key_down, :key_up, :mouse_down, :mouse_up, :mouse_move].each do |event|
        define_method("wait_for_#{event}") do
          SHREDULER.sleep_current_til(event)
        end

        define_method("on_#{event}") do |&blk|
          spork do
            loop do
              ev = SHREDULER.sleep_current_til(event)
              blk[ev]
            end
          end
        end
      end
    end
    
    class RuckSketch
      include ::GLApp

      def initialize(filenames)
        @filenames = filenames
      end

      def setup
        @filenames.each do |filename|
          SHREDULER.spork(filename) do
            require filename
          end
        end
        @events = []

        SHREDULER.starting
      end

      def draw
        @events.each do |pair|
          ev, queue = pair
          SHREDULER.raise_event ev, queue
        end
        @events = []

        SHREDULER.catch_up # execute shreds whose time came while drawing previous frame

        SHREDULER.raise_event Object.new, :frame
      end

      def keyboard_down(key, modifiers)
        @events << [Struct.new(:key).new(key), :key_down]
      end

      def keyboard_up(key, modifiers)
        @events << [Struct.new(:key).new(key), :key_up]
      end

      def special_keyboard_down(key, modifiers)
        @events << [Struct.new(:key).new(key), :key_down]
      end

      def special_keyboard_up(key, modifiers)
        @events << [Struct.new(:key).new(key), :key_up]
      end

      def mouse_click(button, state, x, y)
        if state == 0
          @events << [Struct.new(:button, :x, :y).new(button, x, y), :mouse_down]
        else
          @events << [Struct.new(:button, :x, :y).new(button, x, y), :mouse_up]
        end
      end

      def mouse_motion(x, y)
        @events << [Struct.new(:x, :y).new(x, y), :mouse_move]
      end
    end
    
  end
end
