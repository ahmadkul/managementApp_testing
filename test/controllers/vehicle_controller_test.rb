require 'test_helper'

class VehicleControllerTest < ActionController::TestCase

  def setup
    @user = User.first
    @vehicle = FactoryBot.create(:vehicle)
  end

  test '(M) test Pay action' do
    sign_in(@user)
    post :pay, params: {id: @vehicle.id}
    # assert_response :redirect
    assert_redirected_to controller: 'vehicle', action: 'view'
  end

  test '(M) Create Vehicle successfully' do
    sign_in(@user)
    post :create, vehicle: {make: 'Chevy', model: 'Malibu', colour: 'Red', license: "K1T590", year: 1980, user_id: 1}
    assert_redirected_to controller: 'vehicle', action: 'view'
  end

  test '(M) Create a Vehicle unsuccessfully' do
    sign_in(@user)
    post :create, vehicle: {make: 'Chevy', model: 'Malibu', colour: 'Red', license: "", year: 1860, user_id: 1}
    assert_template 'vehicle/new'
  end

  test '(M) Test delete route' do
    sign_in(@user)
    delete :delete, id: @vehicle.id, user_id: @user.id
    # expect(response).to redirect_to(vehicle_view_path(id: @user.id))
    assert_redirected_to controller: 'vehicle', action: 'view', params: {id: @user.id}

  end

  test '(M) Update action' do
    sign_in(@user)
    patch :update, id: @vehicle.id, vehicle: {make: 'Chevy', model: 'Malibu', colour: 'Red', license: "KTFDC7", year: 1901}
    assert_redirected_to controller: 'vehicle', action: 'view', params: {id: @user.id}
  end
end