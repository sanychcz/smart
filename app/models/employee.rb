class Employee < ActiveRecord::Base
  attr_accessible :address, :birthday, :company_id, :email, :name, :phone, :position, :surname

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }  
  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, presence: true, numericality: { only_integer: true }, length: {is: 9}
  validates :company_id, presence: true

  belongs_to :company

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |employee|
        csv << employee.attributes.values_at(*column_names)
      end
    end
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
