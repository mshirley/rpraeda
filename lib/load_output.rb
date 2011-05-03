def load_output(projname, outfile)
	if projname.empty?
		projname = "praeda-#{Time.now.day}-#{Time.now.month}-#{Time.now.year}"
	end

	if outfile.empty?
		outfile = ""
	end
end

def write_log(message)


end
