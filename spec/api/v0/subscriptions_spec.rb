require 'rails_helper'

RSpec.describe "Subscriptions API", type: :request do
  let!(:customer) { create(:customer) }
  let!(:tea) { create(:tea) }
  let!(:subscriptions) { create_list(:subscription, 5, customer: customer, tea: tea) }
  let(:customer_id) { customer.id }
  let(:id) { subscriptions.first.id }

  describe "GET /customers/:customer_id/subscriptions" do
    before { get "/customers/#{customer_id}/subscriptions" }

    it "returns subscriptions" do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe "POST /customers/:customer_id/subscriptions" do
    let(:valid_attributes) { { subscription: { title: "Monthly Oolong Tea", price: 20.00, status: "active", frequency: "monthly", tea_id: tea.id } } }

    context "when the request is valid" do
      before { post "/customers/#{customer_id}/subscriptions", params: valid_attributes }

      it "creates a subscription" do
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['title']).to eq("Monthly Oolong Tea")
      end
    end

    context "when the request is invalid" do
      before { post "/customers/#{customer_id}/subscriptions", params: { subscription: { title: nil } } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(JSON.parse(response.body)['errors']).to include("Title can't be blank")
      end
    end
  end

  describe "DELETE /customers/:customer_id/subscriptions/:id" do
    before { delete "/customers/#{customer_id}/subscriptions/#{id}" }

    it "cancels the subscription" do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['status']).to eq("cancelled")
    end
  end
end
