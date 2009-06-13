class Message < ActiveRecord::Base
  validates_length_of :body, :in => 5..200
  def due_at
    Time.now + lifespan
  end

  def lifespan
    read_attribute('lifespan') || 5.days
  end
end
