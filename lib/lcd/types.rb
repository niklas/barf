module LCD
  module Types
    def write_val(val)
      write_raw (val.to_i+48).to_hex
    end
  end
end
