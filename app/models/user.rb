# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :posts
  has_many :likes
  has_many :followeds, class_name: "Following", foreign_key: "follower_id"
  has_many :followers, class_name: "Following", foreign_key: "followed_id"

  has_one_attached :photo

  validates :name, presence: true
end
