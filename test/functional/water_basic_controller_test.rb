require 'test_helper'

class WaterBasicControllerTest < ActionController::TestCase


  describe "Country Page" do

    it "should return the country view" do
      get :country
      expect(response).to render_template('blergh')
    end

    #it "country should return to country when an invalid country posted" do
    #  post :water
    #
    #  assert_response :success
    #end
    #
    #test "country should return a message when an invalid country posted" do
    #  post :water
    #
    #  assert_response :success
    #end
    #
    #test "country should return the water view when valid country posted" do
    #  post :water
    #
    #  assert_response :success
    #end
  end

  #
  #
  #
  #test "should get population" do
  #  get :population
  #  assert_response :success
  #end
  #
  #test "should get capital" do
  #  get :capital
  #  assert_response :success
  #end
  #
  #test "should get recurrent" do
  #  get :recurrent
  #  assert_response :success
  #end
  #
  #test "should get time" do
  #  get :time
  #  assert_response :success
  #end
  #
  #test "should get quantity" do
  #  get :quantity
  #  assert_response :success
  #end
  #
  #test "should get quality" do
  #  get :quality
  #  assert_response :success
  #end
  #
  #test "should get reliability" do
  #  get :reliability
  #  assert_response :success
  #end

end
