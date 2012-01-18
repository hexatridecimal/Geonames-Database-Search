namespace :geonames do
  task :import => :environment do
    desc "Import geonames data downloaded into db/US.txt"
    File.open(Rails.root.join("db", "US.txt")).each_line do |line|
      line.chomp!
      row = line.split("\t")
      names = [row[1]]
      row[2].split(",").each do |alt|
        names.push alt
      end
      lat = row[3]
      lon = row[4]
      state = row[10]
      names.each do |name|
        STDERR.puts "Importing #{name}, #{state}: #{lat},#{lon}"
        name = City.make_name(name)
        city = City.where(:name => name, :state => state).first
        next if city
        city = City.new
        city.name = name
        city.state = state
        city.metaphone = City.make_metaphone(name)
        city.latitude = lat
        city.longitude = lon
        city.save
      end
    end
  end
end
