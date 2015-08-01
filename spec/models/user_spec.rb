require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:usercomics) }
  it { should have_many(:comics).through(:usercomics) }

  # it { should validate_uniqueness_of(:twitter_uid) }

  it "is valid username, and twitter_uid" do
    user = User.new(
      username: 'Comicman12',
      twitter_uid: 123456 
      )

    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(
      twitter_uid: 1234
      )

    expect(user).to be_invalid
  end
end
