class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: { allow_blank: false }

  has_many :expenses, foreign_key: 'author_id'
  has_many :groups

  def total_expenses
    return @total unless @total.nil?

    @total = expenses.inject(0) { |sum, expense| sum + expense.amount }
  end
end
