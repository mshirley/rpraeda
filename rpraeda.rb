#!/usr/bin/ruby

require 'lib/include'

#if not defined?(Ocra) # This app supports Ocra (https://github.com/larsch/ocra)

create_lists()

# read in file with list of ips/hosts
server = "localhost"

# read from argv
port = "1234"

# read scheme from argv
scheme = "http"

jobdir = "./jobs"

response = fetch(scheme, server, port, "/")
jobs = "" 

# thanks for help with indexs, apeiros #ruby freenode
$versionlist.each_with_index.select { |version,i| 
	if response['Server'] == version and response['Title'] == $namelist[i]
		puts "Match Found for #{$idlist[i]} #{$namelist[i]}"
		puts $idlist[i]
		jobs << $joblist[i]	
	end 
}.map(&:last)

jobarray = jobs.split(",").uniq

jobarray.each { |job| puts "Executing job #{job}"; load("#{jobdir}/#{job}.rb") }





#$idlist[i]
#$namelist[i]
#$versionlist[i]
#$joblist[i]

#end # Ocra end, leave this
