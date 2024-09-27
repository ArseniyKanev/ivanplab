class User < ActiveRecord::Base
  has_many :download_actions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :password_confirmation, confirmation: true, on: :create
  validates :password, confirmation: true, on: :create
end
