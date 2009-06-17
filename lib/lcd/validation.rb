module LCD
  module Validation
    def validate(val, accepted)
      raise ArgumentError, "wrong argument #{val}, accepts #{accepted}" unless accepted === val
    end
  end
end
