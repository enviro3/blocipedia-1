require 'faker'

User.destroy_all

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

# Create an admin user
admin = User.new(
  name:       'Admin User',
  email:      'admin@example.com',
  password:   'helloworld',
  role:       'admin'
  )
admin.skip_confirmation!
admin.save!

# Create a premium user
premium = User.new(
  name:       'Premium User',
  email:      'premium@example.com',
  password:   'helloworld',
  role:       'premium'
  )
premium.skip_confirmation!
premium.save!

# Create member user
member = User.new(
  name:       'Member User',
  email:      'member@example.com',
  password:   'helloworld',
  )
member.skip_confirmation!
member.save!

users = User.all

puts "#{User.count} users created."

# Create Wikis
users.each do |user|
  5.times do
    user.wikis.create!(
      title:    Faker::Lorem.word,
      body:     Faker::Lorem.paragraph,
      private:  rand(1..5) !=1
    )
  end
end

puts "#{Wiki.count} wikis created"
puts "#{Wiki.where(private: true).count} private wikis created."

puts "Seed finished"