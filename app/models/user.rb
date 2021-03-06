# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :password_digest, :session_token, presence: true
    before_validation :ensure_session_token

    def self.generate_session_token
        SecureRandom.base64
    end

    def self.find_by_credentials(email, password)
      user = User.find_by(email: email)

      if user.is_password?(password)
        user
      else
        nil
      end

    end

    def reset_session_token!
      self.session_token = User.generate_session_token
      self.save!
      self.session_token
    end

    def ensure_session_token
      self.session_token ||= User.generate_session_token
    end


    def password=(password)
      digest = BCrypt::Password.create(password)
      self.password_digest = digest
    end

    private
    def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
    end


end
