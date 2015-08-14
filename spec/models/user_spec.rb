require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:usercomics) }
  it { should have_many(:comics).through(:usercomics) }

   it { should validate_uniqueness_of(:twitter_uid) }

  it "is valid username, and twitter_uid" do
    user = User.new(
      username: 'Comicman12',
      twitter_uid: 123456 
      )

    expect(user).to be_valid
  end

  describe '#this_weeks_comics' do
    let(:fake_hash) { { "store_date" => Comic.comic_date(Date.today),
                        "description" => "put your desc here",
                        "image" => { "thumb_url" => "put your url here" },
                        "name" => "put your name here"
                    } }

    let(:user) { FactoryGirl.create(:user) }
    let(:comic) { FactoryGirl.create(:comic) }

    before :each do 
      allow_any_instance_of(Comicvine).to receive(:get_last_issue_for_volume).and_return(fake_hash)
    end

    it 'returns empty array if user has no comics' do
      expect(user.this_weeks_comics).to be_empty
    end

    it 'will return an Issue instance' do
      user.usercomics.build(comic_id: comic.id).save

      issue = user.this_weeks_comics.first

      expect(issue.comic_release_date.strftime('%F')).to eq(fake_hash['store_date'])
      expect(issue.description).to eq(fake_hash['description'])
      expect(issue.image_url).to eq(fake_hash['image']['thumb_url'])
      expect(issue.name).to eq(fake_hash['name'])
    end

    it 'will not make more than one issue for the same issue' do
      user.usercomics.build(comic_id: comic.id).save
      user.usercomics.build(comic_id: comic.id).save

      issues = user.this_weeks_comics

      expect(issues.uniq.length).to eq(1) 
    end
  end

end
