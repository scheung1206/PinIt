require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rooms_index_url
    assert_response :success
  end

  test "should get create" do
    get rooms_create_url
    assert_response :success
  end

  test "should get party" do
    get rooms_party_url
    assert_response :success
  end

  test "should get config_opentok" do
    get rooms_config_opentok_url
    assert_response :success
  end

end
