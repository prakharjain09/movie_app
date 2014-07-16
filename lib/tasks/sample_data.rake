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

    movie1 = Movie.create!(name: "3 Idiots", director: " Rajkumar Hirani", cast: "Aamir Khan, Madhavan, Mona Singh", info: " Two friends are searching for their long lost companion. They revisit their college days and recall the memories of their friend who inspired them to think differently, even as the rest of the world called them .", release_date: "2014-07-20")
    movie2 = Movie.create!(name: "Transformers: Age of Extinction", director: "Michael Bay", cast: "Mark Wahlberg, Nicola Peltz, Jack Reynor", info: " A mechanic and his family join the Autobots as they are targeted by a bounty hunter from another world.", release_date: "2014-07-20")
    movie3 = Movie.create!(name: "The Avengers", director: "Joss Whedon", cast: "Robert Downey Jr., Chris Evans, Scarlett Johansson ", info: "Nick Fury of S.H.I.E.L.D. assembles a team of superheroes to save the planet from Loki and his army.", release_date: "2014-07-20")
    movie4 = Movie.create!(name: "Thor", director: " Kenneth Branagh, Joss Whedon", cast: " Chris Hemsworth, Anthony Hopkins, Natalie Portman", info: " The powerful but arrogant god Thor is cast out of Asgard to live amongst humans in Midgard (Earth), where he soon becomes one of their finest defenders.", release_date: "2014-07-20")
    movie5 = Movie.create!(name: "Dawn of the Planet of the Apes", director: "Matt Reeves", cast: "Gary Oldman, Keri Russell, Andy Serkis", info: " In the wake of a disaster that changed the world, the growing and genetically evolving apes find themselves at a critical point with the human race.", release_date: "2014-07-20")
    movie6 = Movie.create!(name: "My Movie", director: "Director ABC", cast: "cast123", info: "asdbjaf afsbjasd achfk kljfbv hdvlsk", release_date: "2014-07-20")
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