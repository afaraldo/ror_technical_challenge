FactoryBot.define do

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Number.number(4) }
  end

  FactoryBot.define do
    factory :client do
      name { Faker::Name.name }
    end
  end


  FactoryBot.define do
    factory :category do
      name { Faker::Commerce.department }
    end
  end

  FactoryBot.define do
    factory :image do
      after(:build) do |image|
        image_path = Rails.root.join('public', 'cellphone.jpeg')
        image.file = Rack::Test::UploadedFile.new(image_path, 'image/jpeg')
      end
    end
  end


  FactoryBot.define do
    factory :purchase do
      client
      product
      quantity { Faker::Number.digit }
      unit_price { product.price }
      total { unit_price * quantity.to_i }
      created_at { Faker::Date.backward(days = 365) }
    end
  end
end