module HackerNews
  class Comment
    attr_accessor :id, :username, :time_string, :level, :children

    def initialize
      @children = []
      yield self if block_given?
    end
  end
end
