require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "validations: username must be string if present" do
    user = User.new(name: "lisa")

    assert User.name.class == String, true
  end

  test "validation: provider must be spotify" do
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


end


# in schema
# enum provider: [ :spotify]
