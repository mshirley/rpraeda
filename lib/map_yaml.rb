def map_yaml(db, label)
        list = []
        for i in 0...db.length
                list << db[i].map { |v| v[label].strip }
        end
        return(list)
end
