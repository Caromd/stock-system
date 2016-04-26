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
end
