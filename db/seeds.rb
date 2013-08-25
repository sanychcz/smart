
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

#Before seeding we have to destroy all previous data.
Company.delete_all
Employee.delete_all
Position.delete_all

# Data
Address1 = %{Praha, Michelská 721/31, 141 00 Praha-Michle}
Address2 = %{Praha, Budějovická 1523/9a, 140 00 Praha-Michle}
Address3 = %{Praha, Fügnerovo náměstí 1806/1, 120 00 Praha-Nové Město}
Address4 = %{Praha, Karlovo náměstí 325/7, 120 00 Praha-Nové Město}
Address5 = %{Beroun, Karla Čapka 1482, 266 01 Beroun-Město}
Address6 = %{Plzeň, alej Svobody 853/55, 323 00 Plzeň-Severní Předměstí}

#seeding
20.times do |n|
  name = "Company#{n}"
  web = "company_#{n}.com"
  company_email = "company_#{n}@email.com"
  phone = "123456789".to_i
  ico = "12345678".to_i
  dic = "12345678".to_i
  address = "Praha #{n}, Namesti_#{n}, 12312#{n}"
  company = Company.create!(name: name, web: web, email: company_email, phone: phone, ico: ico, dic: dic, address: address)

  1.times do |p|

  	positions = ["Manager", "Director", "Developer", "Analyst", "Accountant", "Team Leader"]

  	positions.each do |pos| 

	    position = company.positions.create! name: pos
         
  		6.times do |e|

	  		employee_name = Faker::Name.first_name
  			employee_surname = Faker::Name.last_name
  			employee_email = Faker::Internet.email
  			addresses = ["Praha, Michelská 721/31, 141 00 Praha-Michle", "Praha, Budějovická 1523/9a, 140 00 Praha-Michle",
  			 "Praha, Fügnerovo náměstí 1806/1, 120 00 Praha-Nové Město", "Praha, Karlovo náměstí 325/7, 120 00 Praha-Nové Město",
  			 "Beroun, Karla Čapka 1482, 266 01 Beroun-Město", "Plzeň, alej Svobody 853/55, 323 00 Plzeň-Severní Předměstí"]

  			#{}"#{employee_name.downcase}_#{employee_surname.downcase}@#{company.name.downcase}.com" 
    		employee = company.employees.create!(company_id: company.id, name: employee_name, surname: employee_surname, phone: phone , email: employee_email, 
    		address: addresses[e], position: position.name, birthday: "#{1+rand(1..11)}.#{1+rand(1..11)}.#{1960+rand(1..20)}".to_date)
    	end
    end	
  end 
end