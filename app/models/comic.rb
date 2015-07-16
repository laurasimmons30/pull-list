class Comic < ActiveRecord::Base
  has_many :usercomics
  has_many :users, :through => :usercomics
end
