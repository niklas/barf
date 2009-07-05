namespace :lcd do
  namespace :daemon do
    desc "Start the LCD daemon"
    task :start => :environment do
      lcd = LCD::Jarltech.new APP_CONFIG[:lcd_device]
      lcd.wrap = true
      while true
        messages = Message.displayed
        if messages.empty?
          sleep 15
        else
          messages.each do |message|
            lcd.clear!
            lcd.brilliance = message.brightness
            lcd.home
            lcd.write_with_delay message.author, 0.15
            lcd.scroll message.body, :line => 1, :wait => true, :speed => 5
            sleep 5
          end
        end
      end
    end
  end
end
