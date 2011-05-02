require 'yaml'

db = YAML.load(File.open("output.yaml"))

def map_yaml(db, label)
list = []
for i in 0...db.length
	list << db[i].map { |v| v[label] }
end

return(list)
end

def output_yaml_map(list)
if list[i] == "" 
	return "Empty Value"
else
	puts list[i].to_s
end
end

puts idlist = map_yaml(db, "id").flatten
puts namelist = map_yaml(db, "name").flatten
puts versionlist = map_yaml(db, "version").flatten
puts joblist = map_yaml(db, "jobs").flatten

for i in 0...idlist.length
	if idlist[i] == "" then puts "ID: Unknown" else puts "ID: #{idlist[i]}" end
	if namelist[i] == "" then puts "NAME: Unknown" else puts "NAME: #{namelist[i]}" end
	if versionlist[i] == "" then puts "VERSION: Unknown" else puts "VERSION: #{versionlist[i]}" end
	if joblist[i] == "" then puts "JOBS: Unknown" else puts "JOBS: #{joblist[i]}" end
end
