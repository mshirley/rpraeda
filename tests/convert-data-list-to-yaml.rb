#!/usr/bin/ruby
# this test is to convert existing data_test file into yaml database

require 'yaml'

data_parsed = []
line = []
hash_temp = []
jobs = 0
jobs_temp = []
jobs_array = []

data_file = File.open("../perl/data/data_list")

data_file.each {|line| data_parsed << line}

for i in 0...data_parsed.length 
	jobs_temp = data_parsed[i].split("|")
	jobs = jobs_temp.count-3
	if jobs != 0
		for i2 in 3...3+jobs
			jobs_array << jobs_temp[i2].to_s.chomp + "," 
		end
	end
	puts "job array is: #{jobs_array}"
	puts "boobies"

	hash_temp << [{"id", data_parsed[i].split("|")[0], "name", data_parsed[i].split("|")[1], "version", data_parsed[i].split("|")[2], "jobs", "#{jobs_array}"}]

	jobs_array.clear

end

for i in 0...data_parsed.length
end

File.open("output.yaml", "w") { |f| f.write(hash_temp.to_yaml) }

