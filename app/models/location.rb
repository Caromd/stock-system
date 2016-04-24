class Location < ActiveRecord::Base
    has_many :documents, :dependent => :restrict_with_error
end
