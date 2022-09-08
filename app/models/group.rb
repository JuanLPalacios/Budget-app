class Group < ApplicationRecord
  ICONS = %w[family_restroom house stadia_controller inventory inventory_2 payments savings movie
             directions_car school apartment].freeze

  validates :name, presence: { allow_blank: false }
  validates :icon, presence: { allow_blank: false }

  belongs_to :user
  has_many :group_expenses, dependent: :delete_all
  has_many :expenses, through: :group_expenses

  def total
    return @total unless @total.nil?

    @total = expenses.inject(0) { |sum, expense| sum + expense.amount }
  end
end
