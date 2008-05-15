require 'serialport.so'
module LCD
  class Jarltech
    def initialize(dev='/dev/tty.usb0')
      @device = dev
      @baud = 9600
      @data_bits = 8
      @stop_bits = 1
      @parity = SerialPort::NONE
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

    def write_with_delay(text,delay=0.2)
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

    private
    def write_raw(data)
      @serial.print data
    end
  end
end

d = LCD::Jarltech.new('/dev/ttyUSB0')
d.clear!
d.write_with_delay("Hello Asses!")
d.next_line
d.write_with_delay("Nice Asses!")
d.next_line
