require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'opens index buletins page' do
    get bulletins_path

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'opens show one bulletin' do
    b = bulletins(:b1)
    get bulletin_path(b)

    assert_response :success
    assert_select 'p', 'Title 1'
    assert_select 'p', 'Text 1'
  end
end
