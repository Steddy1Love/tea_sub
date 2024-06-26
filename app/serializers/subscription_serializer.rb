class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency
  belongs_to :tea
  belongs_to :customer
end
