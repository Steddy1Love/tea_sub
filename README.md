# Tea Subscription API

This API allows customers to subscribe to different tea subscriptions, manage their subscriptions, and view their subscription history. The application is built with Ruby on Rails and follows RESTful principles.

## Getting Started

### Prerequisites

- Ruby 2.7.2
- Rails 6.0.3
- PostgreSQL

### Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/Steddy1Love/tea_sub.git
   cd tea_sub
   ```
2. Install dependecies:
  ```sh
  bundle install
  ```
3. Setup database:
  ```sh
  rails db:create
  rails db:migrate
  ```
4. Run tests to verify working code version:
  ```sh
  bundle exec rspec
  ```
5. Start the server:
  ```sh
  rails server
  ```

## API Endpoints
### Subscriptions
  - Create Subscription
    - POST '/api/v0/customers/:customer_id/subscriptions'
    - Request Body:
    ```json
    {
      "title": "Monthly Oolong Tea",
      "price": 20.00,
      "status": "active",
      "frequency": "monthly",
      "tea_id": 1
    }
    ```
    - Response:
    ```json
      {
        "data": {
          "id": "1",
          "type": "subscription",
          "attributes": {
            "title": "Monthly Oolong Tea",
            "price": 20.00,
            "status": "active",
            "frequency": "monthly",
            "tea_id": 1
          }
        }
      }
      ```
  - Cancel Subscription
    - DELETE '/api/v0/customer/:customer_id/subdcriptions/:id'
    - Response:
    ```json
      {
        "data": {
          "id": "1",
          "type": "subscription",
          "attributes": {
            "title": "Monthly Oolong Tea",
            "price": 20.00,
            "status": "cancelled",
            "frequency": "monthly",
            "tea_id": 1
          }
        }
      }
      ```
    - List All Subscriptions
      - GET '/api/v0/customers/:customer_id/subscriptions'
      - Response:
      ```json
      {
        "data": [
          {
            "id": "1",
            "type": "subscription",
            "attributes": {
              "title": "Monthly Oolong Tea",
              "price": 20.00,
              "status": "active",
              "frequency": "monthly",
              "tea_id": 1
            }
          },
          ...
        ]
      }
      ```
## Models
### Tea
  - Attributes:
    - Title
    - Description
    - Temperature
    - Brew Time
### Customer
  - Attributes:
    - First Name
    - Last Name
    - Email
    - Address
### Subscription
  - Attributes:
    - Title
    - Price
    - Status
    - Frequency
    - Tea ID
    - Customer ID
## Contributing
Fork the repository
Create your feature branch (git checkout -b feature/new-feature)
Commit your changes (git commit -am 'Add new feature')
Push to the branch (git push origin feature/new-feature)
Create a new Pull Request

## Contact
For more information, contact the repository owner.