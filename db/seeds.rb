# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.find_or_create_by_name('Emanuel', city: cities.first)

user = User.create(email: "adrian@email.com", password: "test1234", role_cd: 1)
Audited.audit_class.as_user(user) do
  cellphone = Product.find_or_create_by_name("Cellphone")
  tv = Product.find_or_create_by_name("TV")
  computer = Product.find_or_create_by_name("Computer")

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

  client = Client.create(name: "Adrian Aguero")
  Purchase.create(client: client, product: tv)
end



