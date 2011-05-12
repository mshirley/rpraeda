#!/usr/bin/ruby
require 'lib/create_lists'
require 'lib/fetch'
require 'lib/load_options'
require 'lib/logging'

if not defined?(Ocra) # This app supports Ocra (https://github.com/larsch/ocra)

targetlist, singletarget, port, projname, outfile = load_options(ARGV)
idlist, namelist, versionlist, joblist = create_lists()

scheme = "http" 
jobdir = "./jobs"
verbose = true # false 

puts "Setting up output dir..."
load_output(projname, outfile)

puts "Current targets:"
puts targetlist

targetlist.each { |target|
	write_log(projname, outfile, verbose, "Scanning #{target}")
	response = fetch(scheme, target, port, "/")
	jobs = "" 

	versionlist.each_with_index.select { |version,i| 
		if response['Server'] == version and response['Title'] == namelist[i]
			write_log(projname, outfile, verbose, "Match Found for #{target} to #{idlist[i]} #{namelist[i]}")
			jobs << joblist[i]	
		end 
	}.map(&:last)
	jobarray = jobs.split(",").uniq
	jobarray.each { |job| 
		write_log(projname, outfile, verbose, "Executing job #{job} against #{target}")
		load("#{jobdir}/#{job}.rb") 
	}
}

end # Ocra end, leave this
