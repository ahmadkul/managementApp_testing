require 'rails_helper'

RSpec.describe VehicleController, type: :controller do

  before do
    # @user = FactoryBot.create(:user)
    @user = User.first
    @vehicle = FactoryBot.create(:vehicle)
  end

  it 'test Pay action' do
    sign_in(@user)
    post :pay, params: {id: @vehicle.id}
    expect(response).to redirect_to(vehicle_view_path)
  end

  it 'Create Vehicle successfully' do
    sign_in(@user)
    post :create, vehicle: {make: 'Chevy', model: 'Malibu', colour: 'Red', license: "K1T590", year: 1980, user_id: 1}
    expect(response).to redirect_to (vehicle_view_path)
  end

  it 'Create a Vehicle unsuccessfully' do
    sign_in(@user)
    post :create, vehicle: {make: 'Chevy', model: 'Malibu', colour: 'Red', license: "", year: 1860, user_id: 1}
    expect(response).to render_template (:new)
  end


  it 'Test delete route' do

    sign_in(@user)
    delete :delete, id: @vehicle.id, user_id: @user.id
    expect(response).to redirect_to(vehicle_view_path(id: @user.id))
  end

  it 'Update action' do
    sign_in(@user)
    patch :update, id: @vehicle.id, vehicle: {make: 'Chevy', model: 'Malibu', colour: 'Red', license: "KTFDC7", year: 1901}
    expect(response).to redirect_to(vehicle_view_path(id: @user.id))
  end

end
