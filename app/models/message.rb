class Message < ActiveRecord::Base
  Lifespans = [
    ['5 Minuten',  5.minutes],
    ['15 Minuten', 15.minutes],
    ['1 Stunde',   1.hour],
    ['3 Stunden',  3.hours],
    ['12 Stunden', 12.hours],
    ['23 Stunden', 23.hours],
    ['1 Tag',       1.day],
    ['5 Tage',      5.days],
    ['1 Woche',     1.week],
    ['1 Monat',     1.month],
    ['3 Monate',    3.months],
    ['ein halbes Jahr', 6.months]
  ]
  validates_length_of :body, :in => 5..200
  def due_at
    Time.now + lifespan
  end

  def lifespan
    read_attribute('lifespan') || 5.days
  end
end
