require 'lib/map_yaml'
require 'lib/load_inv'

def create_lists()
        db = load_inv()
        
        idlist = map_yaml(db, "id").flatten
        namelist = map_yaml(db, "name").flatten
        versionlist = map_yaml(db, "version").flatten
        joblist = map_yaml(db, "jobs").flatten
	return [ idlist, namelist, versionlist, joblist ]
end
