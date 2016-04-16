class Document < ActiveRecord::Base
  belongs_to :user
  has_many :lines
  accepts_nested_attributes_for :lines, reject_if: :all_blank
  validates :code, presence: true, uniqueness: true
end
