# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  acts_as_target
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :echoes, foreign_key: 'echoer_id'

  has_many :communities, foreign_key: 'admin_id'
  has_many :community_memberships
  has_many :memberships, through: :community_memberships, source: :community

  has_many :received_follows, class_name: 'Follow', foreign_key: 'following_id', dependent: :destroy
  has_many :followers, through: :received_follows, source: :follower

  has_many :follows_given, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :follows_given, source: :following

  has_one_attached :avatar

  validates :username, uniqueness: true, presence: true, length: { minimum: 3, maximum: 14 }
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { in: 8..50 }
  validates :bio, length: { maximum: 200 }
end
