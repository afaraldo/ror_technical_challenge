# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.find_or_create_by_name('Emanuel', city: cities.first)

user = User.create(email: "afaraldo.dev@gmail.com", password: "test1234", role_cd: 1)
user2 = User.create(email: "afaraldo.dev+prueba1@gmail.com", password: "test1234", role_cd: 1)
user3 = User.create(email: "afaraldo.devprueba2@gmail.com", password: "test1234", role_cd: 0)

Audited.audit_class.as_user(User.first) do
  5.times do
    FactoryBot.create(:category)
  end

  image = FactoryBot.create(:image)
  Category.all.map do |category|
    10.times do
      product = FactoryBot.create(:product)
      product.images << image
      product.categories << category
    end
  end

  Product.all.map do |product|
    product.categories << Category.all[rand(0..4)]
  end

  Product.all.map do |product|
    10.times do
      FactoryBot.create(:purchase, product: product, quantity: rand(1..10))
    end
  end
end