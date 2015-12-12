# Have you ever had to sleep() in Capybara-WebKit to wait for AJAX and/or CSS animations?

describe 'Modal' do
  
  should 'display login errors' do
    visit root_path
    click_link 'My HomeMarks'
    within '#login_area' do
      fill_in 'email', with: 'will@not.work'
      fill_in 'password', with: 'test'
      click_button 'Login'
    end
    # DO NOT sleep(1) HERE!
    assert_modal_visible
    page.find(modal_wrapper_id).text.must_match %r{login failed.*use the forgot password}i
  end
  
end

# Avoid it by using Capybara's #wait_until method. My modal visible/hidden helpers
# do just that. The #wait_until uses the default timeout value.

def modal_wrapper_id
  '#hmarks_modal_sheet_wrap'
end

def assert_modal_visible
  wait_until { page.find(modal_wrapper_id).visible? }
rescue Capybara::TimeoutError
  flunk 'Expected modal to be visible.'
end

def assert_modal_hidden
  wait_until { !page.find(modal_wrapper_id).visible? }
rescue Capybara::TimeoutError
  flunk 'Expected modal to be hidden.'
end

# Examples of waiting for a page loading to show and hide in jQuery Mobile.

def wait_for_loading
  wait_until { page.find('html')[:class].include?('ui-loading') }
rescue Capybara::TimeoutError
  flunk "Failed at waiting for loading to appear."
end

def wait_for_loaded
  wait_until { !page.find('html')[:class].include?('ui-loading') }
rescue Capybara::TimeoutError
  flunk "Failed at waiting for loading to complete."
end

def wait_for_page_load
  wait_for_loading && wait_for_loaded
end

