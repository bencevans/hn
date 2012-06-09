require "spec_helper"

FakeWeb.register_uri :get, 'http://news.ycombinator.com/item?id=4084603', :body => fixture('comments.html')

module HackerNews
  describe CommentParser do
    subject { CommentParser.new }
    it { should respond_to :parse }
    let(:parser) { subject }
    it "should parse comments" do
      comments = parser.parse(4084603)
      comments.should be_an Array
      comments.count.should == 27

      c = comments.first
      c.should be_a Comment
      c.username.should == 'eykanal'
      c.time_string.should == '14 hours ago'
      c.id.should == '4085001'
      c.level.should == 0
      c.children.count.should == 4

      c.children.first.children.count.should == 2
      c.children.last.children.count.should == 0
    end
  end
end
