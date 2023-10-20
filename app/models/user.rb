# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :password_salt

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :leave_requests, dependent: :destroy
  validates :salary, :role, presence: true

  validates :name, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/,
                             message: 'should be in characters only' }

  validates :password, length: { in: 8..15, message: 'must be between 8 to 15 characters' }

  validates :email, uniqueness: { message: 'is already exist' },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              message: '%<value>s not a valid email !!!' },
                    exclusion: { in: %w[hr@gmail.com],
                                 message: '%<value>s is reserved.' }
  # def decrypted_password
  #   Devise::Encryptable::Encryptors::Aes256.decrypt(encrypted_password, Devise.pepper)
  # end
end
