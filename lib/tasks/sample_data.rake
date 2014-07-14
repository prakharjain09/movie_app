namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    movie = Movie.create!(name: "My Movie", director: "Director ABC", cast: "cast123", info: "asdbjaf afsbjasd achfk kljfbv hdvlsk", release_date: "2014-07-20")
    99.times do |n|
      name  = Faker::Name.name
      director = "Director-#{n+1}"
      cast  = "Cast-#{n+1}"
      info  = Faker::Lorem.sentence
      release_date = "2014-07-20"

      Movie.create!(name: name, director: director, cast: cast, info: info, release_date: release_date)

    end
  end
end