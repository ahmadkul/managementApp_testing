require 'rails_helper'

RSpec.feature "AdminSides", type: :feature do

  before do |example|
    @user = User.find_by_email('admin@mail.com')

    unless example.metadata[:skip_before]
      visit root_url
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: "password"
      click_button 'Log in'
    end
  end

  scenario "Admin enters correct username and password, should see admin view" do

    # save_and_open_page

    expect(page).to have_content(/Signed in successfully/i)
    expect(page).to have_content(/Users currently registered in the system/i)
  end

  scenario "Admin enters incorrect username and password, should fail ", skip_before: true do

    visit root_url

    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: "randomtext"

    click_button 'Log in'

    expect(page).to have_content(/Invalid Email or password/i)
  end

  scenario "Admin Tries to register, enters right info, should see email sent ", skip_before: true do

    visit root_url

    click_link 'sign up'

    fill_in 'user_email', with: 'admin2@mail.com'
    fill_in 'user_password', with: "password2"
    fill_in 'user_password_confirmation', with: 'password2'

    select('Admin', :from => 'user_role')

    fill_in 'user_fName', with: 'Admin'
    fill_in 'user_lName', with: 'Test'
    fill_in 'user_address', with: '260 JuoK street'
    fill_in 'user_city', with: 'Main'
    fill_in 'user_pCode', with: 'K1H 9O0'
    fill_in 'user_telephone', with: '6131234567'

    click_button 'Sign up'

    expect(page).to have_content(/A message with a confirmation link has been sent to your email address. Please follow the link to activate your account/i)

  end

  scenario "Admin Logs in, checks first user, sees 1 vehicle registered, and pays for it, DB should be updated accordingly" do

    click_link 'View'
    click_button 'Pay'

    expect(page).to have_no_content(/Pay/i)
    expect(page).to have_content(/Paid/i)
    expect(page).to have_content(/user's vehicles/i)

  end

  scenario "Admin Logs in, checks first user, deletes user, all revelvent data should no longer exisit" do

    click_link 'Delete'

    expect(page).to have_content(/No users to display/i)
  end
end
