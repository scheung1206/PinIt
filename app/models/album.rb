class Album < ApplicationRecord
  belongs_to :user
  has_many :pins
  has_many :albumPins, dependent: :destroy 
end
