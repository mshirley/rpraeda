require 'optparse'
require 'lib/load_targets'

def load_options(options)
	targets = ""
	singletarget = ""
	port = ""
	projname = ""
	outfile = ""
	opts = OptionParser.new do |opts|
		opts.banner = "Usage: ./rbpraeda.rb -t <targetfile> -p <port> -n <project directory> -o <output file>"
		opts.on("-t=","--targets=<targetfile>", "List of targets") do |val|
			targets = val
		end
		opts.on("-s=", "--single=<host>", "Single target (overrides target list)") do |val|
			singletarget = val
		end
		opts.on("-p=","--port=<port>", "Port to check, this overrides existing ports specified in target list") do |val|
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

	# When a singletarget is specified on the cli it will override targetfile
	if singletarget.empty?
		targetlist = load_targets(targets)
	else
		targetlist = singletarget.to_s
	end

	case
	when targetlist.empty? || targetlist.include?("ERROR") & singletarget.empty?
		puts "ERROR: Invalid target file or no single target specified"
		puts opts
		exit
	when port.empty?
		puts "ERROR: Invalid port"
		puts opts
		exit
	end

	if projname.empty?
		projname = "logs-#{Time.now.month}-#{Time.now.day}-#{Time.now.year}"
		puts "Using default projname: #{projname}"
	end
	
	if outfile.empty?
		outfile = "outfile-#{Time.now.month}-#{Time.now.day}-#{Time.now.year}.log"
		puts "Using default outfile: #{outfile}"
	end

	puts "outfile is #{outfile}"
	return [ targetlist, singletarget, port, projname, outfile ]
end
