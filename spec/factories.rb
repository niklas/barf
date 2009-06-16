Factory.define 'message' do |f|
  f.author 'Princess Leia'
  f.body "A Message"
  f.due_at Time.now + 10.minutes
end
