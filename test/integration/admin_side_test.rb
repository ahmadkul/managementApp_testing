require 'test_helper'

class AdminSideTest < ActionDispatch::IntegrationTest

  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  test 'Admin enters correct username and password, should see admin view' do

    @user = User.find_by_email('admin@mail.com')

    visit root_url
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: "password"
    click_button 'Log in'

    assert page.has_content?(/Signed in successfully/i)
    assert page.has_content?(/Users currently registered in the system/i)
  end

  test 'Admin enters incorrect username and password, should fail' do

    @user = User.find_by_email('admin@mail.com')

    visit root_url

    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: "randomtext"

    click_button 'Log in'

    assert page.has_content?(/Invalid Email or password/i)
  end

  test 'Admin Tries to register, enters right info, should see email sent' do

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

    assert page.has_content?(/A message with a confirmation link has been sent to your email address. Please follow the link to activate your account/i)
  end


  test 'Admin Logs in, checks first user, sees 1 vehicle registered, and pays for it, DB should be updated accordingly' do

    @user = User.find_by_email('admin@mail.com')

    visit root_url
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: "password"
    click_button 'Log in'

    click_link 'View'
    click_button 'Pay'

    assert page.has_no_content?(/Pay/i)
    assert page.has_content?(/Paid/i)
    assert page.has_content?(/user's vehicles/i)

  end

  test 'Admin Logs in, checks first user, deletes user, all revelvent data should no longer exisit' do

    @user = User.find_by_email('admin@mail.com')

    visit root_url
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: "password"
    click_button 'Log in'

    click_link 'Delete'

    assert page.has_content?(/No users to display/i)

  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end