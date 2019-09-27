namespace :dev do
  desc "Configure development environment"

  task setup: :environment do
    
    puts"------------------------------------------------"

    puts 'Registering contact kinds...'
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

    puts"------------------------------------------------"

    puts 'Registering phone numbers...'
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end

    

  end
end
