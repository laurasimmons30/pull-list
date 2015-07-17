class ComicsController < ApplicationController
  def index
    #response = HTTParty.get("http://www.comicvine.com/api/issues?api_key=#{ENV['COMICVINEKEY']}")
    x = Comicscraper.new
    array = ['MARVEL COMICS','DARK HORSE COMICS','DC COMICS','IDW PUBLISHING','IMAGE COMICS','BOOM! STUDIOS']
    @this_week_comics = x.new_comics_for_week('this-week', array)
    #HTTParty.get()
    # http://beta.comicvine.com/api/THING/THING_ID?api_key=ENV["COMICVINEKEY"]

  end
end
