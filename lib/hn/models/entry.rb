module HackerNews
  class Entry
    attr_accessor :id, :title, :link, :site, :points, :num_comments, :time_string, :username

    def initialize
      yield self if block_given?
      self
    end
  end
end
