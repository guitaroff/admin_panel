class User < ApplicationRecord
  acts_as_token_authenticatable
  mount_uploader :avatar, AvatarUploader
  attribute :api, :boolean

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :avatar, presence: true, unless: :api

  protected

  def password_required?
    self.persisted? ? false : super
  end
end
