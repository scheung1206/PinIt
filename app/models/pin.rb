class Pin < ActiveRecord::Base
	searchkick
	acts_as_votable
	belongs_to :user
	has_many :comments
	before_save :parse_yt_link

	has_attached_file :image, :styles => { :medium => "300x300>"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	def parse_yt_link
	  if self.ytlink?
	  self.ytlink = YouTubeAddy.extract_video_id(ytlink)
	else
	  self.ytlink = nil
	end
	end


end
