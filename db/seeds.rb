[
  { email_address: "alex.fuchs970@gmail.com", firstname: "Alexander", lastname: "Fuchs", password: "alexander", role: "alex" },
  { email_address: "test@test.com", firstname: "test", lastname: "test", password: "test", role: "normal" }
].each do |user|
  User.find_or_create_by!(email_address: user[:email_address]) do |u|
    u.password = user[:password]
    u.firstname = user[:firstname]
    u.lastname = user[:lastname]
    u.role = user[:role]
  end
end
