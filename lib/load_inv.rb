require 'rubygems'
require 'yaml'

def load_inv()
        if File.exist?("inventory.yaml")
                puts "Inventory found, loading..."
                inventorydb = YAML.load(File.open("inventory.yaml"))
        return inventorydb
        else
                puts "inventory.yaml not found, use the perl db conversion rb to create a new one"
        exit
        end
end
