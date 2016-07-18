require 'faker'

def create_static_user(attributes)
  unless User.find_by(email: attributes[:email])
    static_user = User.create!(attributes)
    static_user.skip_confirmation!
    puts "created static #{attributes[:name]}."
    puts "Email: #{attributes[:email]} Password: #{attributes[:password]}"
  else
    puts "Skipped creation of \"#{attributes[:email]}\""
  end
end

# Create Users
10.times do
  user = User.new(
    name:      Faker::Name.name,
    email:     Faker::Internet.email,
    password: 'helloworld'
    )
  user.skip_confirmation!
  user.save!
end
puts "Random Users created."

# Create an admin user
create_static_user({
  name:       'Admin User',
  email:      'admin@example.com',
  password:   'helloworld',
  role:       'admin'
})


# Create a premium user
create_static_user({
  name:       'Premium User',
  email:      'premium@example.com',
  password:   'helloworld',
  role:       'premium'
})

# Create member user
create_static_user({
  name:       'Member User',
  email:      'member@example.com',
  password:   'helloworld',
})

users = User.all

puts "#{User.count} users created."

# Create Wikis
users.each do |user|
  5.times do
    user.wikis.create!(
      title:    Faker::Lorem.word,
      body:     Faker::Lorem.paragraph,
      private:  false
    )
  end
end

puts "#{Wiki.count} wikis created"

puts "Seed finished"