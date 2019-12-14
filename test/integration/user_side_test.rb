require 'test_helper'

class UserSideTest < ActionDispatch::IntegrationTest

  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

    def setup
      @user = User.find_by_email('user@mail.com')

      visit(root_url)
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: "password"
      click_button 'Log in'
    end

    test "User enters correct login info, should see user view" do

      assert page.has_content?(/Signed in successfully/i)
      assert page.has_content?(/user's vehicles/i)

    end

    test "User logs in, registers a new vheicle, should see it in view" do

      click_button 'Create new vehicle'

      fill_in 'vehicle_license', with: 'KLOPIO'
      fill_in 'vehicle_colour', with: 'RED'
      fill_in 'vehicle_make', with: 'GMC'
      fill_in 'vehicle_model', with: 'Taho'
      fill_in 'vehicle_year', with: '1970'

      click_button 'Save changes'

      assert page.has_content?('GMC')
    end

    test "User registers 2 vehicles with same information, shoudl fail" do

      click_button 'Create new vehicle'

      fill_in 'vehicle_license', with: 'KTF'
      fill_in 'vehicle_colour', with: 'RED'
      fill_in 'vehicle_make', with: 'Chevy'
      fill_in 'vehicle_model', with: 'Taho'
      fill_in 'vehicle_year', with: '1970'

      click_button 'Save changes'

      page.has_content?(/License has already been taken/i)

    end

    # scenario "after having two vehicles registered, user pays for both, they should both show paid status" do
    # end

    test "User tries to register a 3rd vehicle, should not see button for adding an additional vehicle" do

      click_button 'Create new vehicle'

      fill_in 'vehicle_license', with: 'KLOPIO'
      fill_in 'vehicle_colour', with: 'RED'
      fill_in 'vehicle_make', with: 'GMC'
      fill_in 'vehicle_model', with: 'Taho'
      fill_in 'vehicle_year', with: '1970'

      click_button 'Save changes'

      assert page.has_no_content?('Create new vehicle')
    end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end