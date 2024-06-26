class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  enum status: { active: 'active', cancelled: 'cancelled' }

  validates :title, :price, :status, :frequency, presence: true
end
