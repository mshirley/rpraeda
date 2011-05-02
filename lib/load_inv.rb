require 'rubygems'
require 'yaml'

def load_inv()
        if File.exist?("inventory.yaml")
                puts "inventory found, loading..."
                inventorydb = YAML.load(File.open("inventory.yaml"))
                puts "inventory loaded"
        return inventorydb
        else
                puts "inventory.yaml not found, use the perl db conversion rb to create a new one"
        exit
        end
end
