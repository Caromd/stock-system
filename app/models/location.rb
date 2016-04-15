class Location < ActiveRecord::Base
    has_many :documents
end
