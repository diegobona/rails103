class PostsController < ApplicationController
  
  
  def index
    @group=Group.find(params[:group_id])
    @posts=Post.all
  end
  
  def new
    @group=Group.find(params[:group_id])
    @post=Post.new
  end
  def create
    @group=Group.find(params[:group_id])
    @post=Post.new(post_params)
    @post.group=@group
    @post.user=current_user
    if @post.save
      redirect_to group_path(@group),notice:"发布主题成功"
    else
      render :new
    end
  end
  
  #需要获取的参数（对应实体变量定义），要根据rake routes中该action对应的url中的参数
  def edit
    #url中有group_id参数
    @group=Group.find(params[:group_id])
    @post=Post.find(params[:id])
  end
  def update
    @group=Group.find(params[:group_id])
    @post=Post.find(params[:id])
    if @post.update(post_params)
      redirect_to account_posts_path
    else
      render "edit"
    end
  end
  
  def destroy
    @group=Group.find(params[:group_id])
    @post=Post.find(params[:id])
    @post.destroy
    flash[:alert]="删除成功"
    redirect_to account_posts_path
    
  end
  
  

  private
  def post_params
    params.require(:post).permit(:content)
  end
  
end
