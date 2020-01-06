class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :avatar, presence: true

  protected

  def password_required?
    self.persisted? ? false : super
  end
end
