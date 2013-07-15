require 'test_helper'

class WaterBasicControllerTest < ActionController::TestCase

  test "should get country" do
    get :country
    assert_response :success
  end

  test "should get water" do
    get :water
    assert_response :success
  end

  test "should get population" do
    get :population
    assert_response :success
  end

  test "should get capital" do
    get :capital
    assert_response :success
  end

  test "should get recurrent" do
    get :recurrent
    assert_response :success
  end

  test "should get time" do
    get :time
    assert_response :success
  end

  test "should get quantity" do
    get :quantity
    assert_response :success
  end

  test "should get quality" do
    get :quality
    assert_response :success
  end

  test "should get reliability" do
    get :reliability
    assert_response :success
  end

end
