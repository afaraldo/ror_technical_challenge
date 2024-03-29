# E-Commerce Backend Demonstration - Ruby on Rails

This Ruby on Rails project serves as a technical demonstration, showcasing an array of backend concepts essential for modern e-commerce platforms. It's designed as a technical challenge to exhibit the implementation and integration of various functionalities in an e-commerce context.

## Core Features

- **Product and Category Management**: Efficient handling of products and their categories, with support for multiple image associations.
- **Purchase Tracking**: Robust system to link purchases with specific products and customers.
- **Administrator Management**: Comprehensive oversight by admin users with detailed action tracking.
- **Transactional Email Sending**: Automated email notifications to administrators for first product purchases.
- **Image Storage Solutions**: Advanced methods for storing and retrieving product images.
- **API Integration with Third-Parties**: Seamless integration with external APIs for extended capabilities.
- **Automated Daily Reporting (Cron Jobs)**: Scheduled tasks for generating and sending daily sales reports.
- **Custom E-commerce Business Logic**: Tailored business logic design and implementation specific to e-commerce needs.
- **REST API Development**: JWT-authenticated REST APIs for administrative and data retrieval purposes.

## Technical Aspects

- **Development Environment**: Developed with Ruby 1.9.3 and Rails 3.
- **Database Management**: Utilizes Postgresql for robust data handling.
- **Rigorous Testing**: Ensures reliability and performance through Rspec testing.
- **Efficient Background Processing**: Employs Sidekiq for handling time-consuming tasks in the background.
- **Optimized for Performance and Security**: Adheres to high-performance SQL standards, Rails security practices, and industry best practices, including CI/CD and linting.

## Advanced Features

- Implements advanced model associations like many-to-many, polymorphism, and inheritance.
- Features optional caching mechanisms for APIs.
- Tracks modifications by admin users within the model logic.
- Supports OpenAPI/Swagger for comprehensive API documentation.

As a technical test, this project not only demonstrates the application of various backend technologies and practices but also highlights efficient, secure, and scalable solutions for e-commerce management challenges.

# To Launch the Project

The application is dockerized, making it straightforward to set up and run:

1. Launch the project using Docker Compose:
`cp .env.example .env`
`docker compose up`

2. Once running, visit the application at:

## Manual Testing

To ensure the application's functionality and performance, manual testing can be performed following the setup. This includes verifying the proper operation of the REST APIs, checking the database interactions, and testing the user interface for product and category management.

As a technical test, this project not only demonstrates the application of various backend technologies and practices but also highlights efficient, secure, and scalable solutions for e-commerce management challenges.

* Login

`curl -X POST 'http://localhost:3000/api/v1/users/login' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{ "email":"afaraldo.dev@gmail.com", "password": "test1234"}'`

* GET http://localhost:3000/api/v1/products/best_sellers

`curl -X GET 'http://localhost:3000/api/v1/products/best_sellers' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MDYwODM1NDF9.7qJuCDUxy3SZL_LBRgNWIwJ39eUGHokrAYTrwNJoij8'`

* GET http://localhost:3000/api/v1/products/more_profit

`curl -X GET 'http://localhost:3000/api/v1/products/more_profit' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MDYwODM1NDF9.7qJuCDUxy3SZL_LBRgNWIwJ39eUGHokrAYTrwNJoij8'`

* GET http://localhost:3000/api/v1/products/

`curl -X 'GET' 'http://localhost:3000/api/v1/products?from=2023-01-01&to=2023-01-23&category_id=1&admin_id=1' \
    -H 'accept: application/json' \
    -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MDYwODM1NDF9.7qJuCDUxy3SZL_LBRgNWIwJ39eUGHokrAYTrwNJoij8'`

* GET http://localhost:3000/api/v1/products/summary

`curl -X 'GET' 'http://localhost:3000/api/v1/products/summary?from=2023-01-01&to=2023-01-23&category_id=1&granularity=daily' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MDYwODM1NDF9.7qJuCDUxy3SZL_LBRgNWIwJ39eUGHokrAYTrwNJoij8'`
