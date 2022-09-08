class GroupsController < ApplicationController
  def index
    @groups = Group
    .includes( :expenses)
    .where(user: current_user)
  end

  def new
    @group = Group.new(icon: Group::ICONS[0])
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
