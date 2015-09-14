class Marvel
  require 'digest'

  md5 = Digest::MD5.new
  md5 << Time.now
  md5 << ENV['MARVELKEY']
  md5 << ENV['MARVEL_SECRET_KEY']
  md5.hexdigest

  def initialize
    @base_url = 'http://gateway.marvel.com:80/v1/public/'
  end

  def base_call(resources, other_params)
    "#{base_url}/#{resources}?#{other_params}&apikey=#{ENV['MARVELKEY']}&#{md5}"
  end

  def comic_series(series_name)
    "titleStartsWith=#{series_name}&seriesType=ongoing&contains=comic&orderBy=startYear&"
  end

  def series_search
    url = base_call("series", comic_series())
  end

end
