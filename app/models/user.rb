class User < ActiveRecord::Base
  has_many :usercomics
  has_many :comics, :through => :usercomics

  def this_weeks_comics
    cv = Comicvine.new

    comics.map do |comic|
      issue = cv.get_last_issue_for_volume(comic.api_key)
      if issue["store_date"] == Comic.comic_date(Date.today) 
        issue
      else
        nil
      end
    end.compact
  end
end
