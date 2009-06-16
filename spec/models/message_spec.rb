require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Message do

  before(:each) do
    @old = Factory :message, :due_at => 5.minutes.ago
    @new = Factory :message, :due_at => Time.now + 5.days
  end

  it "old should be due" do
    @old.should be_due
    @old.state.should == 'due'
  end

  it "new should not be due" do
    @new.should_not be_due
    @new.state.should == 'displayed'
  end
    
  describe "searching for due messages" do
    it "should find due message" do
      Message.due.should include(@old)
    end

    it "should not find new message" do
      Message.due.should_not include(@new)
    end
  end


  describe "searching for new messages" do
    it "should find new message" do
      Message.displayed.should include(@new)
    end

    it "should not find due message" do
      Message.displayed.should_not include(@old)
    end
  end

end
