require 'rails_helper'

RSpec.describe Comic, type: :model do
  it { should have_many(:usercomics) }
  it { should have_many(:users).through(:usercomics) }
  it { should have_many(:issues) }

  describe "#self.comic_date" do

    let(:wednesday) { '2015-08-12' }

    it 'returns the wednesday date for current week if monday or tuesday' do
      date = Date.new(2015,8,11)
      
      expect(Comic.comic_date(date)).to eq(wednesday)
    end

    it 'returns the previous wednesday date for current week if thur-sun'do
      date = Date.new(2015,8,14)

      expect(Comic.comic_date(date)).to eq(wednesday)
    end
  end
end
