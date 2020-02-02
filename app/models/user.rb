class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #用户创建的group（和加入的group还不一样）
  has_many :groups
  has_many :posts
  has_many :group_relationships
  #user和joined_groups(加入的版块)多对多关系，通过中间表group_relationships
  has_many :joined_groups,:through => :group_relationships,:source => :group
  
  def is_member_of?(group)
    joined_groups.include?(group)
  end
  def join(group)
    joined_groups << group
  end
  def quit(group)
    joined_groups.delete(group)
  end
end
