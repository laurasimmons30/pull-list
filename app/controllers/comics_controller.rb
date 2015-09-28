class ComicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    comicscraper = Comicscraper.new
    comicvine = Comicvine.new
    marvel = Marvel.new

    array = ['MARVEL COMICS','DARK HORSE COMICS','DC COMICS','IDW PUBLISHING','IMAGE COMICS','BOOM! STUDIOS']
    @this_week_comics = comicscraper.new_comics_for_week('this-week', array)
  end

  def create
    comic_volume_info.each do |info|
      id, name = info.split('---')      
      comic = Comic.find_or_create_by(name: name, api_key: id)
      Usercomic.find_or_create_by(user_id: current_user.id, comic_id: comic.id)
    end
    redirect_to comics_path
  end

  def pull_list
    @comics = current_user.comics
  end

  def pull_list_show
    @comic = Comic.find(params["id"])
    marvel = Marvel.new
    # @comic_info = marvel.
    # comicvine = Comicvine.new
    # @comic_info = comicvine.issue_info(@comic.api_key.to_i)
    # @comic_info = @comic_info["response"]["results"]["issue"]
  end

  def search
    @client = Marvel::Client.new

    @client.configure do |config|
      config.api_key = ENV['MARVELKEY']
      config.private_key = ENV['MARVEL_SECRET_KEY']
    end

    query = params[:comic_name]
    @client.series(titleStartsWith: query, orderBy: '-startYear', limit: 25 )
    # comicvine = Comicvine.new
    # marvel = Marvel.new
    binding.pry
    # @comics = marvel.series_search(query).select { |series|}
    # @comics = comicvine.volume_ids(query).select { |volume| volume["start_year"].to_i > 2005 }.sort_by { |vol| vol["start_year"]}.reverse
    
    respond_to do |format|
      format.js { render "search.js.erb" }
    end
  end

  private
  def comic_volume_info
    params.select { |key, value| key.include?('comicid_') }.values
  end
end
