

class User < ActiveRecord::Base
  validates :provider, presence: true
  validates :uid, presence: true 

  def self.find_or_create_from_omniauth(auth_hash)
  # Find or create a user
    user = self.find_by(uid: auth_hash["info"]["id"], provider: auth_hash["provider"])
    if !@user.nil?
      return user
    else
      user = User.new
      user.uid = auth_hash["info"]['id']
      user.provider = auth_hash['provider']
      user.name = auth_hash["info"]["display_name"]
      user.photo_url = auth_hash["info"]['images'][0]['url']

      if user.save
        return user
      else
        return nil
      end
    end
  end
end
