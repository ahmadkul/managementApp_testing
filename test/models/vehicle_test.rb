# require 'test_helper'

class VehicleTest < ActiveSupport::TestCase

  def setup
    @user = FactoryBot.create(:user, email: 'mike2@mail.com')
    @vehicle1 = FactoryBot.create(:vehicle, user_id: @user.id, paid: 'paid')
    @vehicle2 = FactoryBot.create(:vehicle, license: 'MOP')
  end

  test '(M) Factory instance valid?' do

    assert @vehicle1.valid?
    assert @vehicle2.valid?
  end

  test '(M) Display correct owner of vehicle' do
    assert_equal @vehicle1.owner, @user
  end

  test '(M) Display full vehicle info' do
    assert @vehicle1.full_info.include?(@vehicle1.make)
    assert @vehicle1.full_info.include?(@vehicle1.model)
    assert @vehicle1.full_info.include?(@vehicle1.colour)
    assert @vehicle1.full_info.include?(@vehicle1.year.to_s)
  end

  test '(M) Display if Vehicle paid for' do
    assert @vehicle1.paid?
    refute @vehicle2.paid?
  end
end