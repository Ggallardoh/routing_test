# db/seed.rb

puts 'Seeding...'
org1 = Organization.create! name: 'Routing'

driver1 = Driver.create! name: 'German', last_name: 'Gallardo', organization: org1
driver2 = Driver.create! name: 'Felipe', last_name: 'Fuentes', organization: org1

Vehicle.create! plate: 'AB-CD-00', driver: driver1
Vehicle.create! plate: 'ZY-XW-99', driver: driver2

coords1 = [{ lat: '-33.440953', lng: '-70.624276' },
           { lat: '-33.438578', lng: '-70.607485' },
           { lat: '-33.462074', lng: '-70.606273' },
           { lat: '-33.461195', lng: '-70.621093' }]
coords2 = [{ lat: '-33.436205', lng: '-70.596780' },
           { lat: '-33.454634', lng: '-70.580236' },
           { lat: '-33.459205', lng: '-70.587848' }]

Route.create! starts_at: '2023-02-08 01:00:00',
              ends_at: '2023-02-08 03:00:00',
              travel_time: 2,
              total_stops: 3,
              action: 'Salida',
              organization: org1,
              driver: driver1,
              coordinates: coords1

Route.create! starts_at: '2023-02-08 02:00:00',
              ends_at: '2023-02-08 04:00:00',
              travel_time: 2,
              total_stops: 3,
              action: 'Llegada',
              organization: org1,
              driver: driver2,
              coordinates: coords2

puts 'Seeding done.'
