class Document < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  belongs_to :user
  belongs_to :location
  validates :location, presence: true
  validates :user, presence: true
  has_many :lines
  accepts_nested_attributes_for :lines, reject_if: :all_blank
end
