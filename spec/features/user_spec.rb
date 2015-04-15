require 'feature_helper'

feature "user functionality", js: true do
  
  context "login functionality" do 
    let!(:user) { create(:user, :email => "user@user.com",
                       :password => "password",
                       :password_confirmation => "password",
                       :first_name => "user",
                       :last_name => "last") }

    it "redirects back to home page if bad login" do
      @user = User.first
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

  context "user sign in function" do 
    let!(:user) { create(:user) }
    let!(:language_ruby) { create(:language, name: "Ruby") }
    let!(:language_js){ create(:language, name: "Javascript") }
    let!(:problem1) { create(:problem, title: "Problem1", slug: "Problem-1") }
    let!(:problem2) { create(:problem, title: "Problem2", slug: "Problem-2") }
    let!(:language_problem_1_ruby) { create(:language_problem, language: language_ruby, problem: problem1) }
    let!(:language_problem_2_ruby) { create(:language_problem, language: language_ruby, problem: problem2) }
    let!(:language_problem_1_js) { create(:language_problem, language: language_js, problem: problem1) }
    let!(:language_problem_1_js) { create(:language_problem, language: language_js, problem: problem2) }  
    create(:user_progress, :user => user, :language_problem => language_problem_1_ruby, :status => 1 )
    create(:user_progress, :user => user, :language_problem => language_problem_2_ruby, :status => 0 )

    before do
      login(user)
      visit '/'
    end

    scenario "shows a user progress with the correct language" do
      click_on 'Add Language Track'
      find('#language_id').find(:xpath, 'option[1]').select_option
      click_link_or_button 'Add a track!'
      expect(page).to have_content(language.name)
    end

    scenario "directs to the first problem when clicking on the language path" do
      click_link("#{language.name}")
      expect(page).to have_content("BACK TO LANGUAGE TRACKS")
    end

    scenario "should render the problems show page when checking current problem" do
      click_link("#{language.name}")
      find(:css, "#current-problem-link-text").click
      binding.pry
      expect(page).to have_content("#{problem.title}")
    end    
  end
end
