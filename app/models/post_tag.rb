class PostTag < ApplicationRecord

# post
  belongs_to :post
# tag
  belongs_to :tag
  
end
