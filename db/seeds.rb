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

Audited.audit_class.as_user(user) do
  cellphone = Product.new
  cellphone.name = "Cellphone"
  cellphone.price = 10_000
  cellphone.save

  tv = Product.new
  tv.name = "TV"
  tv.price = 15_000
  tv.save

  computer = Product.new
  computer.name = "Computer"
  computer.price = 30_000
  computer.save

  entertainment = Category.find_or_create_by_name("Entertainment")
  electronics = Category.find_or_create_by_name("Electronics")
  computing = Category.find_or_create_by_name("Computing")

  cellphone.categories << [electronics]
  tv.categories << [electronics, entertainment]
  computer.categories << [electronics, entertainment,computing]

  cellphone_image_path = Rails.root.join('public', 'cellphone.jpeg')
  image1 = Image.new
  image1.file = File.new(cellphone_image_path)
  image1.save

  tv_image_path = Rails.root.join('public', 'tv.webp')
  image2 = Image.new
  image2.file = File.new(tv_image_path)
  image2.save

  computer_image_path = Rails.root.join('public', 'computer.jpeg')
  image3 = Image.new
  image3.file = File.new(computer_image_path)
  image3.save

  cellphone_image_path2 = Rails.root.join('public', 'cellphone2.jpeg')
  image4 = Image.new
  image4.file = File.new(cellphone_image_path2)
  image4.save

  computer_image_path2 = Rails.root.join('public', 'computer2.jpeg')
  image5 = Image.new
  image5.file = File.new(computer_image_path2)
  image5.save

  cellphone.images << [image1, image4]
  tv.images << [image2]
  computer.images << [image3, image5]

  10.times do |number|
    Client.create(name: "Adrian Aguero #{number}")
  end

  Purchase.create(client: Client.first, product: tv, quantity: 5, unit_price: tv.price, total: 5 * tv.price)
  Purchase.create(client: Client.all[3], product: tv, quantity: 10, unit_price: tv.price, total: 10 * tv.price)
  Purchase.create(client: Client.all[1], product: cellphone, quantity: 20, unit_price: cellphone.price, total: 20 * cellphone.price)
  Purchase.create(client: Client.all[4], product: cellphone, quantity: 3, unit_price: cellphone.price, total: 3 * cellphone.price)
  Purchase.create(client: Client.all[2], product: computer, quantity: 5, unit_price: computer.price, total: 5 * computer.price)
  Purchase.create(client: Client.all[5], product: computer, quantity: 5, unit_price: computer.price, total: 5 * computer.price)
end