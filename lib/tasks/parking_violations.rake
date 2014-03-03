namespace :nyimport do
    desc "import"
    task :parking_violations do
        puts "starting to read in CSV"

        require 'csv'

        CSV.foreach 'parking_violations.csv' do |row|
            puts "a row"
            puts row
        end
    end
end
