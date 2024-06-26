class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  enum status: { active: 'active', cancelled: 'cancelled' }
end
