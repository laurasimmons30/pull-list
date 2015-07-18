class ComicsController < ApplicationController
  def index
    #response = HTTParty.get("http://www.comicvine.com/api/issues?api_key=#{ENV['COMICVINEKEY']}")
    x = Comicscraper.new
    array = ['MARVEL COMICS','DARK HORSE COMICS','DC COMICS','IDW PUBLISHING','IMAGE COMICS','BOOM! STUDIOS']
    @this_week_comics = x.new_comics_for_week('this-week', array)
    #HTTParty.get()
    # http://beta.comicvine.com/api/THING/THING_ID?api_key=ENV["COMICVINEKEY"]
  end

  def create
    comic_volume_info.each do |info|
      id, name = info.split('---')
      binding.pry
    end

  end

  def search
    query = params[:comic_name]
    comicvine = Comicvine.new

    @comics = comicvine.volume_ids(query).select { |volume| volume["start_year"].to_i > 2005 }.reverse
    
    respond_to do |format|
      format.js { render "search.js.erb" }
    end
  end

  private
  def comic_volume_info
    params.select { |key, value| key.include?('comicid_') }.values
  end
end
