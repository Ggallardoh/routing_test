# db/seed.rb

puts 'Seeding...'
org1 = Organization.create! name: 'Routing'

driver1 = Driver.create! name: 'German', last_name: 'Gallardo'
driver2 = Driver.create! name: 'Felipe', last_name: 'Farias'

vehicle1 = Vehicle.create! plate: 'AB-CD-00', organization: org1
vehicle2 = Vehicle.create! plate: 'ZY-XW-99', organization: org1

Route.create! starts_at: '2023-02-08 01:00:00',
              ends_at: '2023-02-08 03:00:00',
              travel_time: 2,
              total_stops: 3,
              action: 'Salida',
              organization: org1,
              driver: driver1

Route.create! starts_at: '2023-02-08 02:00:00',
              ends_at: '2023-02-08 04:00:00',
              travel_time: 2,
              total_stops: 3,
              action: 'Llegada',
              organization: org1,
              driver: driver2
puts 'Seeding done.'
