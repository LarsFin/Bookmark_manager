def visit_home
  visit('/home')
end

def visit_addlink
  visit('/addlink')
end

def add_test02_link
  fill_in 'name', with: 'Test02'
  fill_in 'url', with: 'http://www.Test02.com'
  click_button 'add'
end

def add_test03_tag_link
  fill_in 'name', with: 'Test03'
  fill_in 'url', with: 'http://www.Test03.com'
  fill_in 'tag', with: 'testing'
  click_button 'add'
end

def add_test04_spectag_link
  fill_in 'name', with: 'Test04'
  fill_in 'url', with: 'http://www.Test04.com'
  fill_in 'tag', with: 'testing04'
  click_button 'add'
end
