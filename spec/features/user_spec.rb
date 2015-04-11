require 'spec_helper'
require 'rails_helper'

describe "login functionality" do
  let(:user){create(:user)}

  it "redirects to the language track page" do
    visit '/'
    click_on "Log In"
    fill_in 'email', :with => user.email
    fill_in 'password', :with => user.password
    click_on "LOG IN"

    expect(page).has_content?('LANGUAGE TRACKS') 
  end

end
