class ExpensesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @expenses = @group.expenses
  end

  def new
    @group = Group.find(params[:group_id])
    @expense = Expense.new
    @groups = [@group.id]
    @errors = []
  end

  def create
    @group = Group.find(params[:group_id])
    @expense = Expense.new(expense_params)
    @expense.author = current_user
    @groups = params[:expense][:groups].compact_blank
    if save_expense_transaction
      redirect_to(group_expenses_path(params[:group_id]), notice: 'Expense was successfully created.')
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def save_expense_transaction
    @errors = []
    ApplicationRecord.transaction do
      if @expense.save
        @groups.each do |group|
          group_expense = GroupExpense.new(group_id: group, expense: @expense)
          unless group_expense.save
            @errors = group_expense.errors
            raise ActiveRecord::Rollback
          end
        end
      else
        @errors = @expense.errors
        raise ActiveRecord::Rollback
      end
    end
    @errors.none?
  end

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
