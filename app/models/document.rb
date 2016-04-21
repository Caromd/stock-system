class Document < ActiveRecord::Base
  belongs_to :user
  has_many :lines
  belongs_to :location
  validates :location, presence: true
#  validates :user, presence: true
  accepts_nested_attributes_for :lines, reject_if: :all_blank
  validates :code, presence: true, uniqueness: true
end
