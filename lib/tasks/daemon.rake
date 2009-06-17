namespace :lcd do
  namespace :daemon do
    desc "Start the LCD daemon"
    task :start => :environment do
      lcd = LCD::Jarltech.new APP_CONFIG[:lcd_device]
      lcd.wrap = true
      while true
        messages = Message.displayed
        messages.each do |message|
          lcd.clear!
          lcd.home
          lcd.scroll message.body, :line => 1, :wait => true
          sleep 5
        end
      end
    end
  end
end
