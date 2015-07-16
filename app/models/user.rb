class User < ActiveRecord::Base
  has_many :usercomics
  has_many :comics, :through => :usercomics
end
