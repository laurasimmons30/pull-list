class ComicVine
  attr_reader :base_url

  def initialize
    @base_url = 'http://www.comicvine.com/api'
  end

  def base_call(resources)
    "#{base_url}/#{resources}/"
  end

  def issues(options='')

    HTTParty.get(base_call('issues'), "api_key=#{ENV['COMICVINEKEY']}")
  end

end
