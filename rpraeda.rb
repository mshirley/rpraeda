#!/usr/bin/ruby
require 'lib/create_lists'
require 'lib/fetch'
require 'lib/load_options'

if not defined?(Ocra) # This app supports Ocra (https://github.com/larsch/ocra)

targetlist, singletarget, port, projname, outfile = load_options(ARGV)
idlist, namelist, versionlist, joblist = create_lists()
#load_output(projname, outfile)

scheme = "http" 
jobdir = "./jobs"

puts "Current targets:"
puts targetlist

targetlist.each { |target|
	puts "Scanning #{target}"
	puts response = fetch(scheme, target, port, "/")
	jobs = "" 

	# thanks for the help with indexs, apeiros #ruby freenode
	versionlist.each_with_index.select { |version,i| 
		if response['Server'] == version and response['Title'] == namelist[i]
			puts "Match Found for #{idlist[i]} #{namelist[i]}"
			puts idlist[i]
			jobs << joblist[i]	
		end 
	}.map(&:last)
	jobarray = jobs.split(",").uniq
	jobarray.each { |job| puts "Executing job #{job}"; load("#{jobdir}/#{job}.rb") }
}

end # Ocra end, leave this
