require 'rubygems'
require 'mechanize'
require 'open-uri'

agent = Mechanize.new
agent.user_agent_alias = 'Windows Firefox'

# Login
page = agent.get('https://www.netflix.com/cl-en/Login')
page.forms[0]['email'] = 'g.uribemontero@gmail.com'
page.forms[0]['password'] = 'panconqueso123'
returned_page = page.forms[0].submit
puts returned_page.uri

# Select user
user_selection_page = agent.get('https://www.netflix.com/browse/genre/1365')
puts user_selection_page.uri
final_page = agent.click(user_selection_page.link_with(:text => /Gon/))
puts final_page.uri

for i in 274..100000 do
	sleep(1.5)
	category_page = agent.get('https://www.netflix.com/browse/genre/' + i.to_s)

	if not defined? category_page.css("span[class='genreTitle']")[0].text
		puts i.to_s + " undefinded"
		next
	end

	cat_name =  category_page.css("span[class='genreTitle']")[0].text
	line = i.to_s + "\t" + cat_name
	puts line

	open('categories.out', 'a') { |f|
  		f.puts line
	}
end

#category_page = agent.get('https://www.netflix.com/browse/genre/1365')
#puts category_page.css("span[class='genreTitle']")[0].text
#File.open('test.txt', 'w') { |file| file.write(testo.body) }