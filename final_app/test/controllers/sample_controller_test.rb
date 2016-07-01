require 'test_helper'

class SampleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get gmaps" do
    get :gmaps
    assert_response :success
  end

  test "should get ckeditor" do
    get :ckeditor
    assert_response :success
  end

  test "should get paperclip" do
    get :paperclip
    assert_response :success
  end

  test "should get growl" do
    get :growl
    assert_response :success
  end

  test "should get recaptcha" do
    get :recaptcha
    assert_response :success
  end

  test "should get friendly_id" do
    get :friendly_id
    assert_response :success
  end

  test "should get kaminari" do
    get :kaminari
    assert_response :success
  end

  test "should get prawn" do
    get :prawn
    assert_response :success
  end

  test "should get datatables" do
    get :datatables
    assert_response :success
  end

  test "should get redis" do
    get :redis
    assert_response :success
  end

  test "should get chartkick" do
    get :chartkick
    assert_response :success
  end

end
