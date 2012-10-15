namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@example.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    admin.toggle!(:activated)
    
    99.times do |n|
      name  = Faker::Name.name
      email = "#{n+1}@example.com"
      password = "password"
      user = User.create!(name: name,
                          email: email,
                          password: password,
                          password_confirmation: password)
      user.tunes.create!(content: "X:1\nT:#{name}'s Tune\nM:3/4\nL:1/8\nK:D\nDDD")
    end
  end
end
