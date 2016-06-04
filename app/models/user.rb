# User object
class User < ActiveRecord::Base
  has_many :books

  def self.omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.token = auth.credentials.token
      user.expires_at = Time.zone.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
