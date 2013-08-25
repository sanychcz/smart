class Position < ActiveRecord::Base
  attr_accessible :company_id, :name

  validates :name, presence: true
  validates :company_id, presence: true

  belongs_to :company
end
