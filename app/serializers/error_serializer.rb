module ErrorSerializer
    def self.serialize(errors)
        return if errors.nil?
        json ={}
            new_hash = errors.to_hash.map do |key, value|
                value.map do |msg|
                    {id: key, title: msg}
                end
            end.flatten
        json[:errors] = new_hash
        json
    end
end