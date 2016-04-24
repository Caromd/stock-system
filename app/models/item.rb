class Item < ActiveRecord::Base
    validates :code, presence: true, uniqueness: true
    validates :description, presence: true
    has_many :lines, :dependent => :restrict_with_error   
    def code_and_description
        "#{code}: #{description}"
    end
end
