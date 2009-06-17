namespace :lcd do
  namespace :daemon do
    desc "Start the LCD daemon"
    task :start => :enviroment do
      require 'jarltech'
      lcd = LCD::Jarltech.new APP_CONFIG[:lcd_device]
      lcd.wrap = true
      while true
        messages = Message.displayed
        messages.each do |message|
          lcd.clear!
          lcd.home
          lcd.write_with_delay message.full_text
        end
      end
    end
  end
end
