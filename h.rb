require 'open-uri'
require 'nokogiri'
require "google_drive"

def crypto

session = GoogleDrive::Session.from_config("client_secret.json")
ws = session.spreadsheet_by_key("1b4dE5cIL5uU73NziU8XTjcNttv1jA9w17-Vo_Kqc6Hg").worksheets[0]

$nx = 2

File.open("URL_Link.txt", "r") do |f|
  
  f.each_line do |line|  	
	#html = Nokogiri::HTML(open("Steve-Jobs.html"))
	html = Nokogiri::HTML(open(line))

	html.css('.price').each do |data|  
  tt = data.text.strip
  ws[$nx, 3] = tt
  $nx = $nx + 1
  end
  #ws.save 
  puts "Market Price"

  $nx = 2
  html.css('.no-wrap.market-cap.text-right').each do |data|  
  tt = data.text.strip
  ws[$nx, 4] = tt
  $nx = $nx + 1
  end
  #ws.save 
  puts "Market Cap"

  $nx = 2
  html.css('.currency-name-container').each do |data|  
  tt = data.text.strip
  ws[$nx, 1] = tt
  $nx = $nx + 1
  end
  #ws.save 
	puts "Name"

  $nx = 1
  html.css('.col-symbol').each do |data|  
  tt = data.text.strip
  ws[$nx, 2] = tt
  $nx = $nx + 1
  end
  #ws.save   
  puts "Symbol"

  ws[2, 5] = Time.now  
  ws.save 

  end
end


end

$i = 0
loop do
  
  $i = $i + 1
  puts Time.now
  crypto
  puts "sleep 30 minutes"
  sleep 1800
  puts $i

end
