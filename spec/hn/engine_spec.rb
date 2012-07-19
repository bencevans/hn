require "spec_helper"

module HackerNews
  describe Engine do
    subject { Engine }
    let(:engine) { subject }
    it { should respond_to :homepage }

    it "should fetch homepage items" do
      engine.homepage.count.should == 30
    end

    it "should fetch best items" do
      engine.best.count.should == 30
    end

    it "should fetch newest items" do
      engine.newest.count.should == 30
    end
  end
end
