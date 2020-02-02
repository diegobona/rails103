class Account::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    #这个实体变量也可以不在controller中定义，也可以在view中直接访问Post.xxx。但这个action必须定义，否则路由匹配不到。
    @myPosts=Post.where(user_id:current_user.id)
  end
  
  
end
