class GroupsController < ApplicationController
  
  before_action :authenticate_user!, only:[:new,:create,:edit,:update,:destroy]
  
  def index
    @groups=Group.all
  end
  
  def show
    @group=Group.find(params[:id])
  end
  
  #new对应表单。填完以后可以送出 (使用 GET )
  def new
    @group=Group.new
  end
  #new 送出来的表单到 create 这个 action，新增一笔数据 ( 使用 POST )
  def create
    @group=Group.new(group_params)
    #group model里定义了belongs_to :user，所以@group.user可以对应到user对象
    #这里把@group所属的user对象指定为 current_user对象。然后他们会自动做关联 也就是@group.user_id会自动变成current_user.id。
    @group.user=current_user
    if @group.save
      redirect_to groups_path
    else
      render "new"
    end
  end
  
  #edit对应表单。填完以后可以送出 (使用 GET )
  def edit
    @group=Group.find(params[:id])
    #直接通过网址访问edit表单页时，也是该action响应；所以要判断如果当前用户不是该group的创建者，重定向到首页，并提示信息（edit按钮在html）
    if current_user!=@group.user
      redirect_to root_path
      flash[:alert]="你没有权限"
    end 
  end
  #edit 送出来的表单可以到 update 这个 action，更新该笔数据 (使用 PUT )
  def update
    @group=Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path,notice:"修改成功"
    else
      render "edit"
    end
  end
  
  def destroy
    @group=Group.find(params[:id])
    @group.destroy
    flash[:alert]="版块删除成功"
    redirect_to groups_path
  end
  
  
  
  private
  def group_params
    params.require(:group).permit(:title,:description)
  end
  
end
