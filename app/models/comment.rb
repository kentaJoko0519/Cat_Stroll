class Comment < ApplicationRecord
  
  
  validates :sentence, presence: true
# post  
  belongs_to :post
# user  
  belongs_to :user
  
end
