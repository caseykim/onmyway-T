require 'rails_helper'

feature 'User signs in through Facebook', %(
  As a user
  I want to sign in with Facebook account
  So that I don't have to sign up
) do
  before { FactoryGirl.create(:line_with_stations) }

  scenario 'user logs in with Facebook' do
    mock_facebook_auth!

    visit root_path
    click_link "Sign In"
    click_link("Sign in with", href: "/auth/facebook")

    expect(page).to have_link("Sign Out", href: destroy_user_session_path)
    expect(current_path).to eq root_path
  end

end
