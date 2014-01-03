desc "Aggregate rents in neighbourhoods and calculate their median difference"
task :calculate_hoods => :environment do

  puts "Recalculating neighbourhoods' rent prices"

  Hood.all.each do |hood|
    print '--> ' + hood.name + ': '
    hood.calculate_rents_difference
    hood.save
    puts '%0.2f%' % hood.diff
  end

  puts "Done."

end
