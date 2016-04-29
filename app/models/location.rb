class Location < ActiveRecord::Base
    has_many :documents, :dependent => :restrict_with_error
    
    def self.to_csv
        attributes = %w{name}
    
        CSV.generate(headers: true) do |csv|
          csv << attributes
    
          all.each do |location|
            csv << location.attributes.values_at(*attributes)
          end
        end
    end    
end
