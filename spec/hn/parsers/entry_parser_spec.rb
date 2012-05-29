require "spec_helper"
require "chronic"

FakeWeb.register_uri :get, 'http://news.ycombinator.com/', :body => fixture('home.html')
FakeWeb.register_uri :get, 'http://news.ycombinator.com/newest', :body => fixture('newest.html')

module HackerNews
  describe EntryParser do
    subject { EntryParser.new }
    it { should respond_to :homepage }
    let(:parser) { subject }

    context "homepage" do
      it "should parse them right" do
        entries = parser.homepage
        entries.count.should == 30
        entries.first.should be_an Entry
        entries.each do |entry|
          entry.id.should > 4000000
          entry.username.should =~ /\w+/
          entry.link.should =~ /^http/ unless entry.site.nil?
          entry.title.should_not be_empty
          entry.num_comments.should > 0
          entry.site.should_not =~ /^http/
          entry.points.should > 0
          Chronic.parse(entry.time_string).should < Time.now
        end
      end
    end

    context "newest" do
      it "should parse them right" do
        entries = parser.newest
        entries.count.should == 30
        entries.first.should be_an Entry
        entries.each do |entry|
          entry.id.should > 4000000
          entry.username.should =~ /\w+/
          entry.link.should =~ /^http/

          if entry.site.nil? # ASK HN
            entry.id.should == entry.link.match(/^http:\/\/news\.ycombinator\.com\/item\?id=(\d+)$/)[1].to_i
          end

          entry.title.should_not be_empty
          entry.num_comments.should >= 0
          entry.site.should_not =~ /^http/
          entry.points.should >= 0
          Chronic.parse(entry.time_string).should < Time.now
        end
      end
    end
  end
end
