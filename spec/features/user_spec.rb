require 'feature_helper'

feature "user functionality" do
  
  context "login functionality" do 
    let!(:user) { create(:user, :email => "user@user.com",
                       :password => "password",
                       :password_confirmation => "password",
                       :first_name => "user",
                       :last_name => "last") }

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
      expect(page).to have_content("Welcome Back, #{user.first_name}")
      expect(page).to have_content('LANGUAGE TRACKS') 
    end
  end

  context "User dashboard functionality" do 
    let!(:user) { create(:user) }
    let!(:language_ruby) { create(:language, name: "Ruby") }
    let!(:language_js){ create(:language, name: "Javascript") }
    let!(:problem1) { create(:problem, title: "Problem1", slug: "Problem-1") }
    let!(:problem2) { create(:problem, title: "Problem2", slug: "Problem-2") }
    let!(:language_problem_1_ruby) { create(:language_problem, language: language_ruby, problem: problem1) }
    let!(:language_problem_2_ruby) { create(:language_problem, language: language_ruby, problem: problem2) }
    let!(:language_problem_1_js) { create(:language_problem, language: language_js, problem: problem1) }
    let!(:language_problem_2_js) { create(:language_problem, language: language_js, problem: problem2) }  
    let!(:user_progress_ruby){ create(:user_progress, :user => user, :language_problem => language_problem_1_ruby, :status => 1 )}

    before do
      login(user)
      visit '/'
    end

    scenario "shows a user progress with the correct language via Javascript" do
      click_on 'Add Language Track'
      find('#language_id').find(:xpath, 'option[1]').select_option
      click_link_or_button 'Add a track!'
      expect(page).to have_content(language_js.name)
    end

    scenario "directs to the first problem when clicking on the language path via Ruby" do
      click_link("#{language_ruby.name}")
      expect(page).to have_content("BACK TO LANGUAGE TRACKS")
    end

    scenario "should render the problems show page when checking current problem" do
      click_link("#{language_ruby.name}")
      find(:css, "#current-problem-link-text").click
      expect(page).to have_content("#{problem1.title}")
    end    
  end
  context "Language dashboard functionality test (Ruby)" do 
    let!(:user) { create(:user) }
    let!(:language_ruby) { create(:language, name: "Ruby") }
    let!(:language_js){ create(:language, name: "Javascript") }
    let!(:problem1) { create(:problem, title: "Problem1", slug: "Problem-1") }
    let!(:problem2) { create(:problem, title: "Problem2", slug: "Problem-2") }
    let!(:language_problem_1_ruby) { create(:language_problem, language: language_ruby, problem: problem1) }
    let!(:language_problem_2_ruby) { create(:language_problem, language: language_ruby, problem: problem2) }
    let!(:language_problem_1_js) { create(:language_problem, language: language_js, problem: problem1) }
    let!(:language_problem_2_js) { create(:language_problem, language: language_js, problem: problem2) }  
    let!(:user_progress_ruby){ create(:user_progress, :user => user, :language_problem => language_problem_1_ruby, :status => 1, :favorite => true )}

    before do
      login(user)
      visit '/'
      click_link("#{language_ruby.name}")
    end

    scenario "clicking on current problem as a new user will direct user to problem 1" do 
      find('#current-problem-link-text').click
      expect(page).to have_content("#{problem1.title}")
    end

    scenario "click on BACK TO LANGUAGE TRACKS goes back to User dashboard" do 
      find('#back-dashboard-link-text').click
      expect(page).to have_content("LANGUAGE TRACKS")
      expect(page).not_to have_content("JAVASCRIPT")
    end

    scenario "if favorite problem exists, link directs them to favorite problem" do
      click_on "1"
      expect(page).to have_content("#{problem1.title}")
    end

    xscenario "can open a modal to create a new chatroom" do 
    end
  end
end
