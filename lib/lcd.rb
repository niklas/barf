require 'serialport'

class Fixnum
  def to_hex
    [self].pack('c')
  end
end

