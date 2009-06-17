module LCD
  module Types
    def write_val(val)
      write_raw (val+48).to_hex
    end
  end
end
