require 'rails_helper'

RSpec.describe Comic, type: :model do
  it { should have_many(:usercomics) }
  it { should have_many(:users).through(:usercomics) }
  it { should have_many(:issues) }

  describe "#self.comic_date" do
    let(:fake_hash) { { "store_date" => Comic.comic_date(Date.today),
                        "description" => "put your desc here",
                        "image" => { "thumb_url" => "put your url here" },
                        "name" => "put your name here"
                    } }
    let(:comic) { FactoryGirl.create(:comic) }
    it 'returns the wednesday date for current week if monday or tuesday' do
      subject {Comic.new}
      expect(Comic.comic_date(Date.today)).to equal(Date.wednesday?)
    end
  end
end
