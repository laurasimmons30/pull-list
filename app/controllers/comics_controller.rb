class ComicsController < ApplicationController
  def index
    response = HTTParty.get("http://www.comicvine.com/api/issues?api_key=#{ENV['COMICVINEKEY']}")

    binding.pry

    #HTTParty.get()
    # http://beta.comicvine.com/api/THING/THING_ID?api_key=ENV["COMICVINEKEY"]
  end

end
