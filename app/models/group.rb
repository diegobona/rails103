class Group < ApplicationRecord
  validates :title,presence: true
  belongs_to :user
  has_many :posts
  has_many :group_relationships
  #group和加入的成员(members)是多对多关系，通过中间表group_relationships
  has_many :members,through: :group_relationships,source: :user
  
end
