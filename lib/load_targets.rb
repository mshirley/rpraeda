def load_targets(targets)
targetsa = []
	if File.exist?(targets)
		puts "Targets file found, loading..."
		tfile = File.open(targets, "r")
		tfile.each_line { |line|
			targetsa.push line.chomp
		}
		puts "Targets loaded"
		puts targetsa
		return targetsa
	else
		return "ERROR: Cannot load targets file, check name and permissions"
	end
end
