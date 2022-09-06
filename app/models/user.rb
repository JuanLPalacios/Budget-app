class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: { allow_blank: false }

  has_many :expenses
  has_many :groups
end
