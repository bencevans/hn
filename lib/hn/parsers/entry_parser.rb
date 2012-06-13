require "nokogiri"
require "open-uri"
require "chronic"

module HackerNews
  class EntryParser
    def homepage
      parse_entries site_name
    end

    def newest
      parse_entries "#{site_name}newest"
    end

    private

    def site_name
      'http://news.ycombinator.com/'
    end

    def parse_entries(url)
      # doc = Nokogiri::HTML(open('spec/fixtures/home.html'))
      doc = Nokogiri::HTML(open(url))
      tbody = doc.at_css('td.title').parent.parent
      trs = tbody.css('tr').to_a

      30.times.map do |i|
        parse_entry(trs, i)
      end.compact
    end

    private

    def parse_entry(trs, i)
      Entry.new do |entry|
        entry.link = trs[i*3].at_css('td.title a')['href']
        entry.link = site_name + entry.link unless entry.link =~ /^http/

        entry.title = trs[i*3].at_css('td.title a').text

        entry.site = trs[i*3].at_css('td.title span.comhead').text.match(/\((.+)\)/)[1] rescue nil
        entry.points = trs[i*3+1].at_css('td.subtext span').text.to_i rescue -1
        entry.username = trs[i*3+1].at_css('td.subtext a').text rescue nil
        entry.time_string = trs[i*3+1].at_css('td.subtext a').next.text.sub('|', '').strip rescue nil
        entry.submitted_at = Chronic.parse entry.time_string
        entry.num_comments = trs[i*3+1].css('td.subtext a')[1].text.to_i rescue -1

        begin
          entry.id = trs[i*3+1].css('td.subtext a')[1]['href'].match(/\d+/)[0].to_i
        rescue
          entry.id = entry.link.match(/^http:\/\/news\.ycombinator\.com\/item\?id=(\d+)$/)[1].to_i
        end
      end
    rescue
      # do nothing
    end
  end
end
