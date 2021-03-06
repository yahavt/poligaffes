class RawPost < ActiveRecord::Base
  include Poligaffes::Cache::Clearer

  after_save :clear_stats_cache
  after_save :clear_homepage_cache

  belongs_to :social_media_account
  has_one :yair, through: :social_media_account

  has_many :posts

  validates :social_media_account, presence: true
  validates :post, presence: true
  validates_uniqueness_of :id_in_site

  has_attached_file :attachment, :default_url => "missing.jpg"
  validates_attachment_content_type :attachment, 
    :content_type => ['video/mp4'],
    :if => :is_type_of_video?
  validates_attachment_content_type :attachment,
     :content_type => [/\Aimage\/.*\Z/],
     :if => :is_type_of_image?
  
  protected
  def is_type_of_video?
    attachment.content_type =~ %r(video)
  end

  def is_type_of_image?
    attachment.content_type =~ %r(image)
  end

  private
  def clear_stats_cache
    Rails.cache.delete 'weekly_activity-cache-key'
  end
end