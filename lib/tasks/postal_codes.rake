
task :load_postal_codes => :environment do

  n = 0

  File.readlines('coimbra_cp.txt').each do |line|
    matches = line.match(/^\d+;\d+;\d+;(.*?);(\d{4};\d{3});(.+)$/)

    address = matches[1]
    address.gsub!(/;\d{4,};/,', ')
    address.gsub!(';',' ')
    address = address.split.join(" ")

    postal_code = matches[2]
    postal_code.gsub!(';','-')

    county = matches[3]

    instance = PostalCode.create(
      :address => address,
      :code => postal_code,
      :county => county
    )
    instance.find_geo_location

    n += 1
    puts n if n % 10 == 0
  end

end

task :fix_postal_codes => :environment do

  base_lat = 40.2184851
  base_lng = -8.429770699999999

  far_postal_codes = []

  PostalCode.all.each do |postal_code|
    distance_to_base = Math.sqrt((postal_code.lat - base_lat)**2 + (postal_code.lng - base_lng)**2)
    far_postal_codes << postal_code if distance_to_base > 0.05
  end

  puts "Recalculating GEO for #{far_postal_codes.size} postal codes"
  n = 0

  far_postal_codes.each do |postal_code|
    postal_code.find_geo_location
    n += 1
    puts n if n % 10 == 0
  end

end
