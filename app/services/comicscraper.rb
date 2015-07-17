require "open-uri"
class Comicscraper 
  attr_reader :base_url
  def initialize
    @base_url = "http://www.comiclist.com/index.php/newreleases/"
  end

  def new_comics_for_week(week, array_of_publishers)
    url = @base_url + week
    doc = Nokogiri::HTML(open(url))

    hash_to_return = {}
    all_paragraphs = doc.css('.post-content p')

    all_paragraphs.each do |para|
      if para.at_css('b') && array_of_publishers.include?(para.at_css('b').text)
        all_books = para.css('a').map { |link| [link.text, link['href']] }
        hash_to_return[para.at_css('b').text] = all_books
      end
    end

    hash_to_return
  end

  # def comic_date(date)
  #   while !date.wednesday?
  #     date = date.next_day
  #   end
  #   date
  # end

  # def comics_for_week(date)
  #   date = comic_date(date)
  #   url = @base_url + construct_url_for_date(date)
  #   doc = Nokogiri::HTML(open(url))

  #   comic_info = doc.css('tr').map do |tr|
  #     [tr.at_css('.col1').text, tr.at_css('.col2').text ]
  #   end.shift
  # end

  # def construct_url_for_date(date)
  #   "id=comiclist_for_#{date.strftime('%m_%d_%Y')}"
  # end
end
