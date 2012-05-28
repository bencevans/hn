require "spec_helper"

module HackerNews
  describe EntryParser do
    subject { EntryParser.new }
    it { should respond_to :home }
  end
end
