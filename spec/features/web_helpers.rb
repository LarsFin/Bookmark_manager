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
