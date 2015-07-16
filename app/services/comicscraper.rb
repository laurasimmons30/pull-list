require "open-uri"
class Comicscraper 
  attr_reader :base_url
  def initialize
    @base_url = "http://www.comiclistdatabase.com/doku.php?"
  end

  def comic_date(date)
    while !date.wednesday?
      date = date.next_day
    end
    date
  end

  def comics_for_week(date)
    date = comic_date(date)
    url = @base_url + construct_url_for_date(date)
    doc = Nokogiri::HTML(open(url))

    comic_info = doc.css('tr').map do |tr|
      [tr.at_css('.col1').text, tr.at_css('.col2').text ]
    end.shift
  end

  def construct_url_for_date(date)
    "id=comiclist_for_#{date.strftime('%m_%d_%Y')}"
  end
end
