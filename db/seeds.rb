# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  { email_address: "alex.fuchs970@gmail.com", password: "alexander", role: "alex" },
  { email_address: "test@test.com", password: "test", role: "normal" }
].each do |user|
  User.find_or_create_by(email_address: user[:email_address]) do |u|
    u.password = user[:password]
    u.role = user[:role]
  end
end
