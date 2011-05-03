require 'optparse'
require 'lib/load_targets'

def load_options(options)
	targets = ""
	singletarget = ""
	port = ""
	projname = ""
	outfile = ""

	opts = OptionParser.new do |opts|
		opts.on("-t=","--targets=<targetfile>", "List of targets") do |val|
			targets = val
		end
		opts.on("-s=", "--single=<host>", "Single target (overrides target list)") do |val|
			singletarget = val
		end
		opts.on("-p=","--port=<port>", "Port to check") do |val|
			port = val
		end
		opts.on("-n=", "--name=<project name>", "Project name") do |val|
			projname = val
		end
		opts.on("-o=", "--output=<output file>", "Output file") do |val|
			outfile = val
		end
		opts.on("-h", "--help", "Display this screen" ) do
			puts opts
			exit
		end
	end
	opts.parse(options)

	if singletarget.empty?
		targetlist = load_targets(targets)
	else
		targetlist = singletarget.to_s
	end

	#outputret = create_output(projname, outfile)

	case
	when targetlist.empty? || targetlist.include?("ERROR") & singletarget.empty?
		puts "ERROR: Invalid target file or no single target specified"
		puts opts
		exit
	when port.empty?
		puts "ERROR: Invalid port"
		puts opts
		exit
	when projname.empty?
		puts "ERROR: Invalid project name"
		puts opts
		exit
	when outfile.empty?
		puts "ERROR: Invalid output file"
		puts opts
		exit	
	end

	return [ targetlist, singletarget, port, projname, outfile ]
end
