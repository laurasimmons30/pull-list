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
    set_marvel_client

    comics.map do |comic|
      stored_issue = comic.issues.where(comic_release_date: Comic.comic_date(Date.today)).first
      if stored_issue.blank?
        issue = @client.series_comics(comic.api_key, dateDescriptor:'thisWeek').try(:first) || nil
        unless issue.blank?
          desc = issue["description"]
          image = "#{issue['images'].first['path']}.#{issue['images'].first['extension']}"
          name = issue["title"]

          Issue.find_or_create_by(comic_id: comic.id, comic_release_date: Comic.comic_date(Date.today),
                    name: name, description: desc, image_url: image)
        end
      else
        stored_issue
      end
    end.compact
  end

  private
  def set_marvel_client
    @client = Marvel::Client.new

    @client.configure do |config|
      config.api_key = ENV['MARVELKEY']
      config.private_key = ENV['MARVEL_SECRET_KEY']
    end
  end
end
