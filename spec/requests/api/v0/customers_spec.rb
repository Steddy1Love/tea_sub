require "rails_helper"

RSpec.describe "Customer Sign Up", type: :request do
  describe 'POST /api/v0/customers' do
    context 'when the request is valid' do
      let(:valid_attributes) do
        {
          first_name: 'Odell',
          last_name: 'Beckam',
          email: 'goodboy@ruffruff.com',
          address: '420 Matcha St.'
        }
      end

      it 'creates a new user' do
        post '/api/v0/customers', params: valid_attributes.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data][:type]).to eq('customer')
        expect(json[:data][:id]).to be_present
        expect(json[:data][:attributes][:first_name]).to eq('Odell')
        expect(json[:data][:attributes][:last_name]).to eq('Beckam')
        expect(json[:data][:attributes][:email]).to eq('goodboy@ruffruff.com')
      end
    end
  end
end