class Bookmark < ApplicationRecord
  
# post
  belongs_to :post
# user
  belongs_to :user
  
  validates :user_id, uniqueness: { scope: :post_id }
  
end
