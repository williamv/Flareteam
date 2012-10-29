# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Organization.create(name: "Flareteam Org",
                    emergency_role: "Test", 
                    primary_contact_name: "Will Anderson",
                    primary_contact_phone: "555-555-5555")
