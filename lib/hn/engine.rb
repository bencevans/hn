module HackerNews
  class Engine
    class << self
      def homepage
        EntryParser.new.homepage
      end

      def best
        EntryParser.new.best
      end

      def newest
        EntryParser.new.newest
      end
    end
  end
end
