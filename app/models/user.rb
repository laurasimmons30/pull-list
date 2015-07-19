class User < ActiveRecord::Base
  has_many :usercomics
  has_many :comics, :through => :usercomics

  def this_weeks_comics
    cv = Comicvine.new

    comics.map do |comic|
      issue = cv.get_last_issue_for_volume(comic.api_key)
      if issue["store_date"] == comic_date(Date.today) 
        issue
      else
        nil
      end
    end.compact
  end

  def comic_date(date)
    if date.cwday < 4 || date.cwday == 7
      while !date.wednesday?
        date = date.next_day
      end
    else
      while !date.wednesday?
        date = date - 1
      end
    end
    date.strftime('%F')
  end
end
