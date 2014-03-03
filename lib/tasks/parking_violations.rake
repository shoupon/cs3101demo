namespace :nyimport do
    desc "import"
    task :parking_violations => :environment do
        puts "starting to read in CSV"

        require 'csv'

        CSV.foreach 'parking_violations_small.csv' do |row|
            v = Violation.new
            v.summon_number = row[0].strip
            v.plate = row[1].strip
            v.state = row[2].strip
            v.vehicle_type = row[3].strip
            v.issue_date = row[4].strip
            v.violation_description = row[5].strip
            v.violation_code = row[6].strip
            v.fine = row[7].to_i
            v.county = row[8].strip
            v.addr_number = row[10].strip
            v.addr_street = row[11].strip
            v.save
        end
    end
end
