# frozen_string_literal: true

User.destroy_all

User.create!([
               {
                 first_name: 'Lisa',
                 last_name: 'Simpson',
                 birthdate: Date.new(1981, 5, 9),
                 zip_code: '62629',
                 referral_code: 'V3GAN5'
               },
               {
                 first_name: 'Marge',
                 last_name: 'Simpson',
                 birthdate: Date.new(1956, 10, 1),
                 zip_code: '62629',
                 referral_code: 'BLU3RR'
               },
               {
                 first_name: 'Bart',
                 last_name: 'Simpson',
                 birthdate: Date.new(1979, 2, 23),
                 zip_code: '62629',
                 referral_code: 'G3TBNT'
               },
               {
                 first_name: 'Homer',
                 last_name: 'Simpson',
                 birthdate: Date.new(1956, 5, 12),
                 zip_code: '62629',
                 referral_code: 'DFB33R'
               }
             ])

Referral.create!([
                   {
                     referrer_id: '1',
                     referee_id: '2',
                     completed_at: Time.now
                   },
                   {
                     referrer_id: '1',
                     referee_id: '3',
                     completed_at: Time.now
                   },
                   {
                     referrer_id: '2',
                     referee_id: '4',
                     completed_at: Time.now
                   }
                 ])

puts "Created #{User.count} user(s) in the #{Rails.env.downcase} database"
puts "Created #{Referral.count} referral(s) in the #{Rails.env.downcase} database"
