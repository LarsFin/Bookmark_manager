def visit_sign_up
  visit('/sign_up')
end

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

def add_test05_multtag_link
  fill_in 'name', with: 'Test05'
  fill_in 'url', with: 'http://www.Test05.com'
  fill_in 'tag', with: '1st tag, 2nd tag'
  click_button 'add'
end

def sign_up_as_test
  fill_in 'email', with: 'test@hotmail.com'
  fill_in 'password', with: 'password'
  fill_in 'confirm_password', with: 'password'
  click_button 'Sign up'
end

def sign_up_as_test_2
  fill_in 'email', with: 'test@hotmail.com'
  fill_in 'password', with: 'password'
  fill_in 'confirm_password', with: 'password'
  click_button 'Sign up'
end

def sign_up_incorrectly
  fill_in 'email', with: 'test@hotmail.com'
  fill_in 'password', with: 'password'
  fill_in 'confirm_password', with: 'wrong'
  click_button 'Sign up'
end
