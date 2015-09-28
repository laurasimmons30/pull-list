# class Marvel
#   require 'digest'


#   def initialize
#     @base_url = 'http://gateway.marvel.com:80/v1/public/'
#   end

#   def base_call(resources, other_params)
#     timestamp = Time.now.strftime('%Y%m%d%H%M%S')
#     # ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150
#     "#{@base_url}/#{resources}?ts=#{timestamp}&apikey=#{api_key}&hash=#{encrypted_key(timestamp)}&#{other_params}"
#   end

#   def encrypted_key(timestamp)
#     md5 = Digest::MD5.new
#     md5 << timestamp + api_key + ENV['MARVEL_SECRET_KEY']
#     md5.hexdigest
#   end

#   def api_key
#     ENV['MARVELKEY']
#   end

#   def comic_series(series_name)
#     "titleStartsWith=#{series_name}&seriesType=ongoing&contains=comic&orderBy=startYear&"
#   end

#   def series_search(series_name_input)
#     url = base_call("series", comic_series("#{series_name_input}"))
#     HTTParty.get(url)
#   end

# end
