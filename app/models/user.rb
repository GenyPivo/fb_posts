class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.from_omniauth(auth)
      user = find_by(provider: auth.provider, uid: auth.uid)
      if user
        user.update(oauth_token: auth.credentials.token)
        user
      else
        User.create!(email: auth.info.email,
          password: Devise.friendly_token[0,20],
          provider: auth.provider,
          uid: auth.uid,
          oauth_token: auth.credentials.token)
      end
  end
end
