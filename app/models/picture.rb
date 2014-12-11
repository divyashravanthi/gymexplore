class Picture < ActiveRecord::Base
  belongs_to :gym
  has_attached_file :image, :styles => { :large => "800x480#", :thumb => "400x240#" }, :default_url => "/assets/:style/placeholder.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def url_json
    self.image.url(:thumb)
  end
end
