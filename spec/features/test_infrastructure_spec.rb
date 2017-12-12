require_relative '../../app.rb'

feature "testing infrastructure" do
  feature '#homepage' do

    before do
      visit_home
    end

    scenario "homepage has content" do
      expect(page).to have_content("Bookmark")
    end

    scenario "homepage should have a link" do
      Link.create(url: 'http://www.test01.com', name: 'Test01')

      visit_home

      within 'ol#links' do
        expect(page).to have_content("Test01 - http://www.test01.com")
      end

    end

    scenario "Should have a link to go to add link page" do
      expect(page).to have_link("here")
      click_link("here")
      expect(page).to have_content("Add-link")
    end

  end

  feature '#addlink page' do

    before do
      visit_addlink
    end

    scenario "addlink page should exist" do
      expect(page.status_code).to be 200
    end

    scenario "addlinkn page should have a field for link name" do
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

  end

end
