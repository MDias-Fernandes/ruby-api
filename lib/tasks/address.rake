namespace :dev do
    desc "Configure development environment"
  
    task set_address: :environment do
      
      puts"------------------------------------------------"
  
      puts 'Registering contacts addresses...'
      Contact.all.each do |contact|
        Address.create(
            street: Faker::Address.street_address,
            city: Faker::Address.city,
            contact: contact
        )
        end
    end
end