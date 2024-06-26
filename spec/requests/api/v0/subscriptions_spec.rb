require 'rails_helper'

RSpec.describe "Api::V0::Subscriptions API", type: :request do
  let!(:customer) { create(:customer) }
  let!(:tea) { create(:tea) }
  let!(:subscriptions) { create_list(:subscription, 5, customer: customer, tea: tea) }
  let(:customer_id) { customer.id }
  let(:id) { subscriptions.first.id }
  let(:headers) { {'Content-Type': 'application/json', "Accept": "application/json"} }
  
  describe "GET /api/v0/customers/:customer_id/subscriptions" do
    before { get "/api/v0/customers/#{customer_id}/subscriptions", headers: headers }
    
    it "returns subscriptions" do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end
  end

  describe "POST /customers/:customer_id/subscriptions" do
    let(:valid_attributes) { { subscription: { title: "Monthly Oolong Tea", price: 20.00, status: "active", frequency: "monthly", tea_id: tea.id } } }

    context "when the request is valid" do
      before { post "/api/v0/customers/#{customer_id}/subscriptions", params: valid_attributes.to_json, headers: headers }

      it "creates a subscription" do
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['data']['attributes']['title']).to eq("Monthly Oolong Tea")
      end
    end

    let(:invalid_attributes) { { subscription: { title: nil } } }
    context "when the request is invalid" do
      before { post "/api/v0/customers/#{customer_id}/subscriptions", params: invalid_attributes.to_json, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(JSON.parse(response.body)['error']).to include("Invalid subscription details")
      end
    end
  end

  describe "DELETE /customers/:customer_id/subscriptions/:id" do
    before { delete "/api/v0/customers/#{customer_id}/subscriptions/#{id}", headers: headers }

    it "cancels the subscription" do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data']['attributes']['status']).to eq("cancelled")
    end
  end
end
