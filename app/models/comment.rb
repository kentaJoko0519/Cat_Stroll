class Comment < ApplicationRecord


  validates :sentence, presence: true
# post
  belongs_to :post
# user
  belongs_to :user


  scope :with_out_is_deleted, -> {includes(:user).where(user: {is_deleted: false})}
end
