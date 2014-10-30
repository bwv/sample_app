require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a', user.name
    end
    assert_select 'a', text: 'delete'
    user = first_page_of_users.first 
    assert_difference 'User.count', -1 do 
      delete user_path(user)
    end
  end

  test "index as non-admin" do 
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index only shows activated users" do
    @non_admin.update_attribute(:activated, false) # Sterling Archer 
    log_in_as(@admin)
    get users_path
    assert_match "Michael Example", response.body
    assert_no_match "Sterling Archer", response.body
  end

  test "unactivated user page redirects to root" do 
    @non_admin.update_attribute(:activated, false) # Sterling Archer
    get user_path(@non_admin)
    assert_redirected_to root_url
    get user_path(@admin)
    assert_template 'users/show'
  end

end
