class UsersController < ApplicationController
  validates_uniqueness_of :twitter_uid
end
