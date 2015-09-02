class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:twitter]
  has_many :usercomics
  has_many :comics, through: :usercomics

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.nickname

      user.password = Devise.friendly_token[0,20]
    end
  end

  def this_weeks_comics
    cv = Comicvine.new

    comics.map do |comic|
      issue = comic.issues.where(comic_release_date: Comic.comic_date(Date.today)).first

      if issue.blank?
        issue = cv.get_last_issue_for_volume(comic.api_key)
        if issue["store_date"] == Comic.comic_date(Date.today)
          desc = issue["description"]
          image = issue["image"]["thumb_url"]
          name = issue["name"]

          Issue.find_or_create_by(comic_id: comic.id, comic_release_date: Comic.comic_date(Date.today),
                    name: name, description: desc, image_url: image)
        else
          nil
        end
      else
        issue
      end
    end.compact
  end
end
