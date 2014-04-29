require 'spec_helper'

feature "User Registration" do
  let(:user) { FactoryGirl.create(:user) }

  scenario "sign up with corret data" do
    visit new_user_registration_path
    fill_in :user_first_name, with: user.first_name
    fill_in :user_last_name, with: user.last_name
    fill_in :user_screen_name, with: user.screen_name
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password_confirmation
    select "18", from: :user_age
    select "Male", from: :user_gender
    click_button("Sign up")
    visit edit_users_additional_path(user)
  end

  scenario "filling in additional information to sign up form" do
    visit edit_users_additional_path(user)
    fill_in :user_about_me, with: user.about_me
    attach_file("Avatar", Rails.root + 'spec/fixtures/images/ruby.png')
    select "Beginner", from: :user_workout_preferences_experience
    select "Strength", from: :user_workout_preferences_exercise_type
    select "Early Morning (6-8am)", from: :user_workout_preferences_prefered_time
    click_button("Sign Up")
    visit user_path
    page.should have_content("Thanks for signing up")
  end
end