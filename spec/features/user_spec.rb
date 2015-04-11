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
    before do 
      user = FactoryGirl.create(:user)
      language = FactoryGirl.create(:language)
      login_as(user, :scope => :user)      
    end

    it "can add a language", js: true do
      visit '/' 
      click_link('Add a Language')
      find('#add-language-track').click
      expect(page).to have_content('BACK TO LANGUAGE TRACKS')
    end
  end
end
