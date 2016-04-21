class Item < ActiveRecord::Base
    has_many :lines
    validates :code, presence: true, uniqueness: true
    validates :description, presence: true
    
    def code_and_description
        "#{code}: #{description}"
    end
end
