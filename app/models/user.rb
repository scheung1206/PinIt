class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :pins, dependent: :destroy
  has_many :friendships
  has_many :comments, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  acts_as_voter


  has_attached_file :avatar, :styles => { :profile => "150x150>", :comment => "75x75>"}
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
