require "nokogiri"
require "open-uri"

module HackerNews
  class EntryParser
    def home
      doc = Nokogiri::HTML(open('spec/fixtures/home.html'))
      tbody = doc.at_css('td.title').parent.parent
      trs = tbody.css('tr').to_a

      30.times.map do |i|
        Entry.new do |entry|
          entry.title = trs[i*3].at_css('td.title a').text
          entry.link = trs[i*3].at_css('td.title a')['href']
          entry.site = trs[i*3].at_css('td.title span.comhead').text.match(/\((.+)\)/)[1] rescue nil
          entry.points = trs[i*3+1].at_css('td.subtext span').text.to_i rescue 0
          entry.user = trs[i*3+1].at_css('td.subtext a').text
          entry.time_string = trs[i*3+1].at_css('td.subtext a').next.text.sub('|', '').strip
          entry.num_comments = trs[i*3+1].css('td.subtext a')[1].text.to_i
          entry.id = trs[i*3+1].css('td.subtext a')[1]['href'].match(/\d+/)[0].to_i
        end
      end
    end
  end
end
