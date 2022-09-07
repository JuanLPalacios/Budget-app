class ExpensesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @expenses = @group.expenses
  end
end
