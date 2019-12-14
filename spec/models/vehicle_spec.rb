require 'rails_helper'

RSpec.describe Vehicle, type: :model do

  before do
    @user = FactoryBot.create(:user, email: 'mike2@mail.com')
    @vehicle1 = FactoryBot.create(:vehicle, user_id: @user.id, paid: 'paid')
    @vehicle2 = FactoryBot.create(:vehicle, license: 'MOP')
  end

  it "Factory instance valid?" do
    expect(@vehicle1).to be_valid
    expect(@vehicle2).to be_valid
  end

  it "Diplays correct owner of vehicle" do
    expect(@vehicle1.owner).to eq @user
  end

  it 'Dispays full vehicle info' do
    expect(@vehicle1.full_info).to include(@vehicle1.make, @vehicle1.model, @vehicle1.colour, @vehicle1.year.to_s)
  end

  it "Displays if vehicle paid for" do
    expect(@vehicle2.paid?).to eq false
    expect(@vehicle1.paid?).to eq true
  end

end

