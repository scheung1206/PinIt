class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :pins
  has_many :friendships
  has_many :comments, dependent: :destroy
  has_many :friends, :through => :friendships


  has_attached_file :avatar, :styles => { :profile => "150x150>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
