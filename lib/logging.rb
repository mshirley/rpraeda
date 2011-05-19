def write_log(projname, outfile, verbose, message)
	File.open("./#{projname}/#{outfile}", 'a') { |file|
		file.write("[#{Time.now}]" + " " + message + "\n")
		if verbose == true
			puts "[#{Time.now}]" + " " + message
		end
	file.close
	}
end

def load_output(projname, outfile)
	if File.directory?("./#{projname}")
		puts "Directory already exists"
	else
		puts "Creating output directory"
		Dir.mkdir("./#{projname}")
	end
end
