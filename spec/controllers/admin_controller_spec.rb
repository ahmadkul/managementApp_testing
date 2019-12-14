require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  it 'HomeController test' do
    user = FactoryBot.build(:user)
    # sign_in(user)
    get :home
    expect(response).to render_template(:home)
  end

end
