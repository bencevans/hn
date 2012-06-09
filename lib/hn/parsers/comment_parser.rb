require "nokogiri"
require "open-uri"
require "chronic"

module HackerNews
  class CommentParser
    def parse(entry_id)
      doc = Nokogiri::HTML(open("http://news.ycombinator.com/item?id=#{entry_id}"))
      comment_data = doc.css('td.default').map { |td| extract_comment_from_td(td) }
      comments = []

      comment_data.each_with_index do |c, index|
        if c.level == 0
          comments << c
        else
          parent = comment_data[0...index].select { |cm| cm.level == c.level - 1 }.last
          parent.children << c
        end
      end

      comments
    end

    private

    def extract_comment_from_td(td)
      Comment.new do |c|
        c.username = td.at_css('span.comhead a').text rescue nil
        c.time_string = td.at_css('span.comhead a').next.text.sub('|', '').strip rescue nil
        c.id = td.css('span.comhead a')[1]['href'].match(/item\?id=(\d+)/)[1] rescue -1
        c.level = td.parent.at_css('td img').attr('width').to_i / 40 rescue 0
      end
    end
  end
end
