class Document < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  before_validation :uppercase_code
  belongs_to :user
  belongs_to :location
  validates :location, presence: true
  validates :user, presence: true
  has_many :lines, :dependent => :restrict_with_error
  accepts_nested_attributes_for :lines, reject_if: :all_blank, allow_destroy: true

  def uppercase_code
    code.upcase!
  end
  
  def self.to_csv
      top_line = %w{Code Date Location User Comment}
  
      CSV.generate(headers: true) do |csv|
        csv << top_line
        all.each do |document|
          csv << [document.code, document.docdate, document.location.name, document.user.username, document.comment]
        end
      end
  end  
end
