class Message < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
  Lifespans = [
    ['5 Minuten',  5.minutes],
    ['15 Minuten', 15.minutes],
    ['1 Stunde',   1.hour],
    ['3 Stunden',  3.hours],
    ['6 Stunden',  6.hours],
    ['12 Stunden', 12.hours],
    ['23 Stunden', 23.hours],
    ['1 Tag',       1.day],
    ['2 Tage',      2.days],
    ['3 Tage',      3.days],
    ['5 Tage',      5.days],
    ['1 Woche',     1.week],
    ['2 Wochen',    1.weeks],
    ['1 Monat',     1.month],
    ['6 Wochen',    6.weeks],
    ['3 Monate',    3.months],
    ['ein halbes Jahr', 6.months]
  ]
  DefaultLifespan = 1.day
  validates_length_of :body, :in => 5..200

  def lifespan=(new_lifespan)
    self.due_at = Time.zone.now + new_lifespan.to_i
  end

  def lifespan
    due_at - Time.zone.now
  end

  def due_at
    read_attribute('due_at') || Time.zone.now + DefaultLifespan
  end

  def due?
    due_at < Time.zone.now
  end

  def state
    due? ? 'due' : 'displayed'
  end

  def full_text
    [author, body].reject(&:blank?).join(': ')
  end

  def brightness
    if due?
      0
    else
      brightness_by_age
    end
  end

  named_scope :skip, lambda {|offset|
    {:offset => offset}
  }
  named_scope :limit, lambda {|limit|
    {:limit => limit}
  }
  named_scope :displayed, lambda {
    { :conditions => ['? < due_at', Time.zone.now] }
  }
  named_scope :due, lambda {
    { :conditions => ['due_at < ?', Time.zone.now] }
  }

  private
  def brightness_by_age
    32 * (due_at - Time.zone.now) / (due_at - updated_at)
  end
end
