require "spec_helper"

module HackerNews
  describe Entry do
    subject { Entry.new { |e| e.id = 1 } }
    it { should respond_to :[] }
    it "should handle []" do
      subject[:id].should == 1
    end
  end
end
