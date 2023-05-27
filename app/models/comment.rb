class Comment < ApplicationRecord
  
# post  
  belongs_to :post
# user  
  belongs_to :user
  
end
