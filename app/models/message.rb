class Message < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
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
  DefaultLifespan = 5.days
  validates_length_of :body, :in => 5..200

  def lifespan=(new_lifespan)
    due_at = Time.now + new_lifespan
  end

  def due_at
    read_attribute('due_at') || Time.now + DefaultLifespan
  end

  named_scope :skip, lambda {|offset|
    {:offset => offset}
  }
  named_scope :limit, lambda {|limit|
    {:limit => limit}
  }
  named_scope :displayed, lambda {
    { :conditions => ['due_at < ?', Time.now] }
  }
  named_scope :due, lambda {
    { :conditions => ['due_at > ?', Time.now] }
  }
end
