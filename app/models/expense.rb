class Expense < ApplicationRecord
  validates :name, presence: { allow_blank: false }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User'
  has_many :group_expenses, dependent: :delete_all
  has_many :groups, through: :group_expenses
end
