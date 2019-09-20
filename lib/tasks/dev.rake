namespace :dev do
  desc "Configure development environment"
  task setup: :environment do

    puts 'Registering contact kinds'
    kinds = ["Amigo", "Conhecido", "Parente"]
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts"------------------------------------------------"

    puts 'Registering contacts...'
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end

  end

end
