require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    #user.photo_url = auth_hash["info"]['images'][0]['url']
     # @known = OmniAuth.config.mock_auth[:spotify_known]
    @known = {
      "provider" => "spotify",
      "info" =>  { "id" => "known_user", "display_name" => "known user" , "images" => ["url" => "http://blah.com"]} }
    @unknown = { "provider" => "spotify", "info" =>
        { "id" => "unknown_user", "display_name" => "unknown user" , "images" => ["url" => "http://blah.com"]} }
    # @unknown = OmniAuth.config.mock_auth[:spotify_unknown]
    @unknown_with_uid = OmniAuth.config.mock_auth[:spotify_uid]
  end

  test "can make a new user given the oauth spotify hash of an unknown user" do
    assert_difference 'User.count', 1 do
      @user = User.find_or_create_from_omniauth @unknown
    end
  end

  test "can find an existing user given an oauth spotify hash" do
    assert_equal users(:known_user), User.find_or_create_from_omniauth(@known)
  end

  test "uses oauth data to set user name, provider and uid for new users" do
   user = User.find_or_create_from_omniauth @unknown

   assert_equal @unknown['info']['display_name'], user.name
   assert_equal @unknown['provider'], user.provider
   assert_equal @unknown['info']['id'], user.uid
  end

  test "validations: username cannot be empty string" do
    bob = User.new
    bob.name = ""
    assert_not bob.valid?
    assert bob.errors.keys.include?(:name), "name is not in the errors hash"
  end

  test "validation: provider must be spotify" do
    user = User.new
    user.provider = "monkey face"
    assert_not user.valid?
    assert user.errors.keys.include?(:provider), "provider is not in the errors hash"
  end


  test "validation: provider must be present" do
    user = User.new
    assert_not user.valid?
    assert user.errors.keys.include?(:provider), "provider is not the errors hash"
  end

  test "validation: uid must be present" do
    user = User.new
    assert_not user.valid?
    assert user.errors.keys.include?(:uid), "uid is not in the errors hash"
  end

  test "can create user from omniauth hash" do

  end


end


# in schema
# enum provider: [ :spotify]
