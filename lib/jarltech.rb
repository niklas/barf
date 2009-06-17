require 'serialport'

class Fixnum
  def to_hex
    [self].pack('c')
  end
end

module LCD
  module Types
    def write_val(val)
      write_raw (val+48).to_hex
    end
  end

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

  module Validation
    def validate(val, accepted)
      raise ArgumentError, "wrong argument #{val}, accepts #{accepted}" unless val === accepted
    end
  end
  class Jarltech
    include Types
    include Scrolling
    include Validation
    def initialize(dev='/dev/tty.usb0')
      @device = dev
      @baud = 9600
      @data_bits = 8
      @stop_bits = 1
      @parity = SerialPort::NONE
      @brilliance = 23
      connect
    end

    def connect
      puts "Connecting to #{@device}"
      @serial = SerialPort.new(@device, @baud, @data_bits, @stop_bits,@partity)
    end

    def write(text)
      puts "Writing '#{text}'"
      write_raw text.to_s
      flush!
    end

    def write_with_delay(text,delay=0.1)
      text.to_s.split(//).each do |c|
        write_raw c
        sleep delay
      end
    end

    def clear!
      write_raw "\x1b:"
    end

    def flush!
      @serial.flush
    end

    def next_line
      write_raw "\n\r"
    end

    alias :reconnect :connect

    def close
      @serial.close
    end

    # Turn wrapping on/off
    # CTRL+A / CTRL+B
    def wrap=(do_wrap)
      case @wrap = do_wrap 
      when true
        write_raw "\x01"
      when false
        write_raw "\x02"
      else
        raise "What wrap??"
      end
    end

    def reset!
      write_raw "\x1c"
    end

    # Set protected mode, yield, clear protected mode
    # ESC,& ... ESC,'
    def protected
      write_raw "\x1b&"
      yield
      write_raw "\x1b'"
    end

    # Protect curso column
    # ESC, V
    def protect_column!
      write_raw "\x1bV"
    end

    # Move cursor left +times+ columns
    # CTRL+H
    def left(times=1)
      write_raw "\b" * times
    end

    # Move cursor right +times+ columns
    # CTRL+H
    def right(times=1)
      write_raw "\f" * times
    end

    # Move cursor up +times+ lines
    def up_with_wrap(times=1)
      write_raw "\v" * times
    end

    alias :up :up_with_wrap

    # Move the cursor down one line
    # CTRL+J
    def line_feed
      write_raw "\n"
    end

    alias :down :line_feed

    # Move cursor to column 0
    # CTRL+M
    def begin_of_line
      write_raw "\r"
    end

    # Homve Cursor home
    # CTRL ^
    def home
      write_raw "\x1e"
    end

    def fade(brilliance,rate=100)
      raise "brilliance to high" if brilliance > 32
      raise "brilliance to low" if brilliance < 0
      raise "rate to high" if rate > 255
      raise "rate to low" if rate < 0
      write_raw "\x1b0#{(brilliance+48).to_hex}#{rate.to_hex}"
      @brilliance = brilliance
    end

    def brilliance=(new_brilliance)
      raise "brilliance to high" if new_brilliance > 32
      raise "brilliance to low" if new_brilliance < 0
      write_raw "\x1bG#{(new_brilliance+48).to_hex}"
      @brilliance = new_brilliance
    end

    #private
    def write_raw(data)
      @serial.print data
    end

    def esc
      write_raw "\e"
    end

    def end_message
      write_raw "\010\013"
    end

    def select_line(line)
      validate line, 0..1
      write_val line
    end


  end

end

#d = LCD::Jarltech.new('/dev/ttyUSB0')
#d.clear!
#d.write_raw "\x1bGZ"
#d.next_line
#d.write_with_delay("Hello Asses!")
#d.next_line
#d.write_with_delay("Hello Titties!")
#d.next_line
#d.write_with_delay("(.)(.)", 0.2)
#
#30.times do |b|
#  sleep 0.1
#end
# letzte 5 vollendete torrents
# df
# transferrate
# jabber
