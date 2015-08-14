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
end
