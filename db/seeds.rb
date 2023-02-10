# db/seed.rb

puts 'Destroying...'

Route.destroy_all
Vehicle.destroy_all
Driver.destroy_all
User.destroy_all
Organization.destroy_all

puts 'Done destroying..'

puts 'Seeding...'

org1 = Organization.create! name: 'Routing'
org2 = Organization.create! name: 'Pricing'

User.create! email: 'routing@fakemail.com', password: '123456', organization: org1
User.create! email: 'pricing@fakemail.com', password: '123456', organization: org2

Driver.create! name: 'Carlos', last_name: 'Carlos', organization: org1
Driver.create! name: 'Adán', last_name: 'Adán', organization: org1
driver1 = Driver.create! name: 'Diego', last_name: 'Diego', organization: org1
Driver.create! name: 'Andrea', last_name: 'Andrea', organization: org2
Driver.create! name: 'Mauro', last_name: 'Mauro', organization: org2

ve1 = Vehicle.create! plate: 'VE1', organization: org1
Vehicle.create! plate: 'VE2', organization: org1
Vehicle.create! plate: 'VE3', organization: org1
Vehicle.create! plate: 'VE4', organization: org1
Vehicle.create! plate: 'VE5', organization: org1
Vehicle.create! plate: 'VE6', organization: org2
Vehicle.create! plate: 'VE7', organization: org2
Vehicle.create! plate: 'VE8', organization: org2

coords1 = [{ lat: '-33.440953', lng: '-70.624276' },
           { lat: '-33.438578', lng: '-70.607485' },
           { lat: '-33.462074', lng: '-70.606273' },
           { lat: '-33.461195', lng: '-70.621093' }]
coords2 = [{ lat: '-33.436205', lng: '-70.596780' },
           { lat: '-33.454634', lng: '-70.580236' },
           { lat: '-33.459205', lng: '-70.587848' }]
coords3 = [{ lat: '-33.465726', lng: '-70.585664' },
           { lat: '-33.469173', lng: '-70.576394' },
           { lat: '-33.486185', lng: '-70.558192' },
           { lat: '-33.473633', lng: '-70.598747' }]

Route.create! name: 'Ruta_1',
              starts_at: '2023-02-08 09:00:00',
              ends_at: '2023-02-08 11:30:00',
              travel_time: 2,
              total_stops: 3,
              action: 'Salida',
              organization: org1,
              coordinates: coords1

Route.create! name: 'Ruta_2',
              starts_at: '2023-02-08 09:00:00',
              ends_at: '2023-02-08 10:10:00',
              travel_time: 2,
              total_stops: 3,
              action: 'Llegada',
              organization: org1,
              coordinates: coords2

Route.create! name: 'Ruta_3',
              starts_at: '2023-02-08 11:00:00',
              ends_at: '2023-02-08 13:30:00',
              travel_time: 2,
              total_stops: 4,
              action: 'Llegada',
              aasm_state: 'scheduled',
              organization: org1,
              coordinates: coords3,
              driver: driver1,
              vehicle: ve1

puts 'Seeding done.'
