# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(provider: "twitter", uid: "9999", name: "Example User", nickname: "user")
10.times do
  source = Faker::LoremPixel.image("260x#{200 + 100 * rand(5)}")
  caption = Faker::Lorem.sentence
  user.fotons.create(source: source, caption: caption)
end
