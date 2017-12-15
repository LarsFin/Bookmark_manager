require_relative '../../app.rb'

feature "testing infrastructure" do

  feature "#sign up page" do

    before do
      visit_sign_up
    end

    scenario "Sign in page has a sign up form" do
      expect(page).to have_field('email')
      expect(page).to have_field('password')
    end

    scenario "Sign in page has a sign up form" do
      expect(page).to have_field('confirm_password')
    end

    scenario "Sign in page has a form sign up button" do
      expect(page).to have_button('Sign up')
    end

    scenario "Submitting form brings you to the homepage" do
      sign_up_as_test
      expect(page).to have_content('Welcome')
    end

    scenario "Checks that email is the same as the persons who logged in" do
      sign_up_as_test
      expect(page).to have_content('Welcome test@hotmail.com')
    end

    scenario "User count should increase by 1" do
      sign_up_as_test
      visit_sign_up
      expect { sign_up_as_test_2 }.to change(User, :count).by(1)
    end

    scenario "Mismatched password input should not create a new user" do
      sign_up_as_test
      visit_sign_up
      expect { sign_up_incorrectly }.not_to change(User, :count)
    end

    scenario "Unsucessful sign up doesn't redirect to homepage" do
      sign_up_incorrectly
      expect(page).to have_field('email')
    end

    scenario 'Unsucessful sign up dislays a message' do
      expect(page).not_to have_content('Password does not match the confirmation')
      sign_up_incorrectly
      expect(page).to have_content('Password does not match the confirmation')
    end

    scenario 'Should not be able to sign up when leaving a blank email address' do
      sign_up_as_test
      visit_sign_up
      expect { sign_up_incorrectly_nomail }.not_to change(User, :count)
    end

    scenario 'Should not be able to sign up when leaving a blank email address' do
      sign_up_as_test
      visit_sign_up
      expect { sign_up_incorrectly_wrong_format }.not_to change(User, :count)
    end

    scenario 'Unable to register two users with identical email' do
      sign_up_as_test
      visit_sign_up
      sign_up_as_test
      expect(page).to have_content('We already have that email')
    end

    scenario 'User can log in' do
      sign_up_as_asd
      visit('/sign_up')
      login_as_asd
      expect(page).to have_content('Search a tag')
    end

    scenario 'Welcome message appears upon successful login' do
      sign_up_as_asd
      visit('/sign_up')
      login_as_asd
      expect(page).to have_content('Welcome asd@hotmail.com')
    end
  end

  feature '#homepage' do

    before do
      visit_home
    end

    scenario "homepage has content" do
      expect(page).to have_content("Bookmark")
    end

    scenario "Should have a link to go to add link page" do
      expect(page).to have_link("here")
      click_link("here")
      expect(page).to have_content("Add-link")
    end

    scenario "Should have a search for tag field" do
      expect(page).to have_field('search_tag')
    end

  end

  feature '#searching a tag' do

    scenario 'Submitting a tag will bring you to a page with only the specific tags' do
      visit_addlink
      add_test03_tag_link
      visit_addlink
      add_test04_spectag_link
      fill_in 'search_tag', with: 'testing04'
      click_button('search')

      expect(page).not_to have_content('Test03')
      expect(page).to have_content('Test04')
    end

  end

  feature '#addlink page' do

    before do
      visit_addlink
    end

    scenario "addlink page should exist" do
      expect(page.status_code).to be 200
    end

    scenario "addlink page should have a field for link name" do
      expect(page).to have_field("name") and have_field("url")
    end

    scenario "addlink page should have an 'add' button" do
      expect(page).to have_button("add")
    end

    scenario "Should have a link to go back home" do
      expect(page).to have_link("here")
      click_link("here")
      expect(page).to have_content('Bookmark')
    end

    scenario "addlink page should allow users to submit a new link with a name and url" do
      add_test02_link

      expect(page).to have_content("Test02 - http://www.Test02.com")
    end

    feature 'User can add tags' do

      scenario 'Add link page should have an enter tag field' do
        visit_addlink

        expect(page).to have_field('tag')
      end

      scenario 'Tags should be added to the links' do
        visit_addlink
        add_test03_tag_link

        expect(page).to have_content("Test03 - http://www.Test03.com #Tags; testing")
      end

      scenario 'Can add multiple tags which are recognized as seperate' do
        visit_addlink
        add_test05_multtag_link
        link = Link.first
        expect(link.tag.count).to eq 2
      end

    end

  end

end
