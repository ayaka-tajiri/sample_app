require 'test_helper'

class MicropostsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
  end

  test "index and pagenation and search" do
    log_in_as(@user)
    get microposts_path
    assert_template 'microposts/index'
    assert_select 'div.pagination'
    assert_select 'div.search'
    first_page_of_microposts = Micropost.paginate(page: 1)
    first_page_of_microposts.each do |micropost|
      assert_select 'a[href=?]', user_path(micropost.user), text: micropost.user.name
    end
    get microposts_url, params: {q: @micropost.content}
    microposts = assigns(:microposts)
    assert microposts.length == 1
  end
end
