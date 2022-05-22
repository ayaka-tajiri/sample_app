require 'test_helper'

class MicropostsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "" do
    log_in_as(@user)

  end
end
