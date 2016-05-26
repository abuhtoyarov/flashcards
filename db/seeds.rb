# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://www.learnathome.ru/blog/100-beautiful-words'))

user = User.create(email: 'user@test.com', password: '123456788', password_confirmation: '123456788')
block = Block.create(title: 'block 1', user: user)


doc.search('//table/tbody/tr').each do |row|
  original = row.search('td[2]')[0].content.downcase
  translated = row.search('td[4]')[0].content.downcase
  Card.create!(original_text: original, translated_text: translated, user: user, block: block)

end
