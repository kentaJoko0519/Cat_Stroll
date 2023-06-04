class Post < ApplicationRecord
  
# user
  belongs_to :user
# post_tags
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
# bookmark
  has_many :bookmarks, dependent: :destroy
# comment
  has_many :comments, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
  
  has_many_attached :images
  def get_image(image, width, height)
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
end
