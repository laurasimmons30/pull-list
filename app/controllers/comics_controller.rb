class ComicsController < ApplicationController
  def index
    comicscraper = Comicscraper.new
    comicvine = Comicvine.new

    array = ['MARVEL COMICS','DARK HORSE COMICS','DC COMICS','IDW PUBLISHING','IMAGE COMICS','BOOM! STUDIOS']
    @this_week_comics = comicscraper.new_comics_for_week('this-week', array)
    @comics = current_user.comics if signed_in?
  end

  def create
    comic_volume_info.each do |info|
      id, name = info.split('---')      
      comic = Comic.find_or_create_by(name: name, api_key: id)
      current_user.comics << comic
    end
    redirect_to comics_path
  end

  def info
    @comic = Comic.find(params[:id])
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
