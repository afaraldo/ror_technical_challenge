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
  # Crea productos, categorías e imágenes al azar
  10.times do
    category = FactoryBot.create(:category)
    random_id = rand(Category.minimum(:id)..Category.maximum(:id))
    random_category = Category.find_by_id(random_id)
    image = FactoryBot.create(:image)

    product = FactoryBot.create(:product)
    product.categories << random_category
    product.images << image
  end

  # Crea clientes al azar
  30.times do
    FactoryBot.create(:client)
  end

  # Crea compras al azar
  60.times do
    FactoryBot.create(:purchase)
  end
end