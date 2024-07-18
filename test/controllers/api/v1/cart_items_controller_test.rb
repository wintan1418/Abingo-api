require "test_helper"

class Api::V1::CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_cart_items_create_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_cart_items_destroy_url
    assert_response :success
  end
end
