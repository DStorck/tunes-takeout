require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "validations: username must be string if present" do
    user = User.new(name: "lisa")

    assert User.name.class == String, true
  end




end


# in schema
# enum provider: [ :spotify]
