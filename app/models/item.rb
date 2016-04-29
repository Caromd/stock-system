class Item < ActiveRecord::Base
    validates :code, presence: true, uniqueness: true
    before_validation :uppercase_code
    validates :description, presence: true
    has_many :lines, :dependent => :restrict_with_error   
    def code_and_description
        
        "#{code}: #{description}"
    end
    def uppercase_code
        code.upcase!
    end
    def self.search(search)
        if search
            where('description LIKE ?', "%#{search}%")
        else
            all
        end
    end
end
