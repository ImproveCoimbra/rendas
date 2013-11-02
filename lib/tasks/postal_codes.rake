
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
