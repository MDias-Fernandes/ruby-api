namespace :dev do
    desc "Configure development environment"
  
    task set_phones: :environment do
      
      puts"------------------------------------------------"
  
      puts 'Registering phone numbers...'
      Contact.all.each do |contact|
        Random.rand(5).times do |i|
          phone = Phone.create!(number:Faker::PhoneNumber.cell_phone)
          contact.phones << phone
          contact.save!
        end
      end
      
    end
end