class Account::GroupsController < ApplicationController
  before_action :authenticate_user!
  def index
    @myJoinedGoups=current_user.joined_groups
  end
end
