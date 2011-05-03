require 'optparse'

targets = ""
port = ""
projname = ""
outfile = ""


opts = OptionParser.new do |opts|
        opts.on("-f=","--targets=<targetfile>", "List of targets") do |val|
                targets = val
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

opts.parse(ARGV)

puts targets
puts port
puts projname
puts outfile

