class Comic < ActiveRecord::Base
  has_many :usercomics
  has_many :users, :through => :usercomics

  def self.comic_date(date)
    if date.cwday < 4
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
