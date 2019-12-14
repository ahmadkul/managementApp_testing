require 'rails_helper'

RSpec.feature "UserSides", type: :feature do

    before do |example|
      @user = User.find_by_email('user@mail.com')

      unless example.metadata[:skip_before]
        visit root_url
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: "password"
        click_button 'Log in'
      end
    end

  scenario "User enters correct login info, should see user view" do

    expect(page).to have_content(/Signed in successfully/i)
    expect(page).to have_content(/user's vehicles/i)

  end

  scenario "User logs in, registers a new vheicle, should see it in view" do

    click_button 'Create new vehicle'

    fill_in 'vehicle_license', with: 'KLOPIO'
    fill_in 'vehicle_colour', with: 'RED'
    fill_in 'vehicle_make', with: 'GMC'
    fill_in 'vehicle_model', with: 'Taho'
    fill_in 'vehicle_year', with: '1970'

    click_button 'Save changes'

    # save_and_open_page

    expect(page).to have_content('GMC')

  end

  scenario "User registers 2 vehicles with same information, shoudl fail" do

    click_button 'Create new vehicle'

    fill_in 'vehicle_license', with: 'KTF'
    fill_in 'vehicle_colour', with: 'RED'
    fill_in 'vehicle_make', with: 'Chevy'
    fill_in 'vehicle_model', with: 'Taho'
    fill_in 'vehicle_year', with: '1970'

    click_button 'Save changes'

    # save_and_open_page

    expect(page).to have_content(/License has already been taken/i)

  end

  # scenario "after having two vehicles registered, user pays for both, they should both show paid status" do
  # end

  scenario "User tries to register a 3rd vehicle, should not see button for adding an additional vehicle" do

    click_button 'Create new vehicle'

    fill_in 'vehicle_license', with: 'KLOPIO'
    fill_in 'vehicle_colour', with: 'RED'
    fill_in 'vehicle_make', with: 'GMC'
    fill_in 'vehicle_model', with: 'Taho'
    fill_in 'vehicle_year', with: '1970'

    click_button 'Save changes'

    expect(page).to have_no_content('Create new vehicle')

  end
end
