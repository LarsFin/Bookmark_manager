feature "testing infrastructure" do
  scenario "homepage has content" do
    visit('/home')

    expect(page).to have_content("Bookmark")
  end

  scenario "homepage should have a link" do
    visit('/home')
    Link.create(url: 'http://www.youtube.com', name: 'Youtube')

    expect(page).to have_content("Youtube - http://www.youtube.com")
  end
end
