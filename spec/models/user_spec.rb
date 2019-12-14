require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.create(:user, email: 'mike1@mail.com')
  end

  it "Factory instance valid?" do
    expect(@user).to be_valid
  end

  it 'Just a Hello world example of model testing' do
    expect(@user.fName).to eq 'Joe'
  end

  it "Display User full name" do
    expect(@user.full_name).to eq @user.fName + ' ' + @user.lName
  end

  it "Display User full Address" do
    address = @user.address
    postal_code = @user.pCode
    city = @user.city
    prov = @user.province

    expect(@user.full_address).to include(address)
    expect(@user.full_address).to include(postal_code)
    expect(@user.full_address).to include(city)
    expect(@user.full_address).to include(prov)

  end

  it "Show cars user has" do
    @veichle = FactoryBot.create(:vehicle, user_id: @user.id)
    expect(@user.cars_owned).to include(@veichle)

  end
end
