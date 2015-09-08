class Comicvine
  attr_reader :base_url
  require 'open-uri'

  def initialize
    @base_url = 'http://www.comicvine.com/api'
  end

  def base_call(resources)
    "#{base_url}/#{resources}/?api_key=#{ENV['COMICVINEKEY']}"
  end

  def issues(options='')
    HTTParty.get(base_call('issues') + options)
  end

  def id_arrays(call)
    y = call["results"]
    array = y.map {|row| row.values}
  end

  def volume_ids(comic_name)
    #returns array of ids and volumes [[773, "Superman"],[776, "Magic Comics"]]
    comic_name = comic_name.gsub(' ', '%20')
    url = base_call("volumes")+"&field_list=id,name,start_year,publisher&filter=name:#{comic_name}&format=json"
    puts "THIS IS THE COMIC NAME: #{comic_name}"
    puts "THIS IS THE URL: #{url}"
    puts "THIS IS THE THINGY"
    puts HTTParty.get(url)
    HTTParty.get(url)["results"].each do |vol|
      vol["publisher"] = vol["publisher"] ? vol["publisher"]["name"] : "Unknown"
    end
  end

  def volume(id, options="")
    url = base_call("volume/4050-#{id}") + "&field_list=last_issue&format=json" + options
    HTTParty.get(url)["results"]
  end

  def issue(id, options="")
    url = base_call("issue/4000-#{id}") + "&format=json" + options
    HTTParty.get(url)["results"]
  end

  def get_last_issue_for_volume(id)
    issue_id = volume(id)["last_issue"]["id"]
    issue(issue_id, '&field_list=name,store_date,image,description,volume,issue_number')
  end

  def publisher_ids
    call = HTTParty.get(base_call("publishers")+"&field_list=id,name&format=json")
    publishers = id_arrays(call)
  end

  def issue_info(id)
    call = HTTParty.get("http://www.comicvine.com/api/issues?api_key=96c05be8131206ff5edd56dbdb9949ad7652dbf8&field_list=id,name,issue_number,description,image&filter=volume:#{id}")
  end
end
