class Report < ApplicationRecord

# user
  belongs_to :reporter, class_name: "User"
  belongs_to :reported, class_name: "User"
  
  enum status: { waiting: 0, keep: 1, finish: 2 } 
  
end
