# require 'test_helper'
# require 'minitest/autorun'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = FactoryBot.create(:user, email: 'mike1@mail.com')
  end

  test '(M) Test Factory' do
    assert @user.valid?
  end

  test '(M) Just a Hello world example of model testing' do
    assert @user.fName == 'Joe'
  end

  test '(M) Display User full name' do
    assert @user.full_name == @user.fName + ' ' + @user.lName
  end

  test '(M) Display User full Address' do

    address = @user.address
    postal_code = @user.pCode
    city = @user.city
    prov = @user.province

    assert_includes @user.full_address, address
    assert_includes @user.full_address, postal_code
    assert_includes @user.full_address, city
    assert_includes @user.full_address, prov

  end

  test '(M) Show cars user has' do
    @veichle = FactoryBot.create(:vehicle, user_id: @user.id)
    assert_includes @user.cars_owned, @veichle
  end
end
