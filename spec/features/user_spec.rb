require 'spec_helper'
require 'rails_helper'

describe "user functionality" do
  context "login functionality" do
    let!(:user){create(:user)}
    it "redirects back to home page if bad login" do
      visit '/'
      click_on "Log In"
      fill_in 'email', :with => user.email
      fill_in 'password', :with => "bananna"
      click_on "LOG IN"
      expect(page).to have_content("Oops! Please try again!")
    end

    it "redirects to the language track page" do
      visit '/'
      click_on "Log In"
      fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_on "LOG IN"
      expect(page).to have_content('LANGUAGE TRACKS') 
    end
  end

  context "authentication page features" do
    # before(:each) do 

    # end
    it "can add a language" do
      @user = create(:user)
      @language_problem = create(:language_problem)
      @language = @language_problem.language
      @problem = @language_problem.problem
      @current_problem = @problem
      visit '/'
      click_on "Log In"
      fill_in 'email', :with => @user.email
      fill_in 'password', :with => @user.password
      click_on "LOG IN"
      click_on 'Add a Language'
      click_link_or_button 'Add a track!'
      save_and_open_page
      # expect(page).to have_content('BACK TO LANGUAGE TRACKS')
    end
  end
end
