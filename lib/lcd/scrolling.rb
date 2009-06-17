module LCD
  module Scrolling
    def scroll(text, options = {})
      options[:block] = block = 1
      define_scroll_message text, block
      start_scrolling options
      if options[:wait]
        sleep 0.1 * text.length
      end
    end

    private
    def define_scroll_message(text, block=1)
      esc
      write_raw "\040"
      select_block block
      write_raw text
      end_message
    end

    def start_scrolling(options={})
      options.reverse_merge!({
        :line => 0,
        :direction => :left,
        :speed => 5,
        :block => 1
      })
      esc
      write_raw "\041"
      select_line      options[:line]
      select_direction options[:direction]
      select_speed     options[:speed]
      select_block     options[:block]
    end

    def select_direction(dir = :left)
      val = case dir
            when :left then 1
            when :right then 0
            else
              raise ArgumentError, "wrong direction: #{dir}"
            end
      write_raw (val+48).to_hex
    end

    def select_speed(speed=5)
      validate speed, 0..16
      write_val speed
    end

    def select_block(block=1)
      validate block, 1..8
      write_val block
    end

  end
end
