class Company < ActiveRecord::Base
  attr_accessible :address, :dic, :email, :ico, :name, :phone, :web

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #VALID_PHONE_REGEX = /^\d{9}$/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }  																	
  validates :ico, presence: true, length: {is: 8}, numericality: { only_integer: true }
  validates :dic, length: {is: 8}, numericality: { only_integer: true }
  validates :name, presence: true
  validates :phone, presence: true, numericality: { only_integer: true }, length: {is: 9}

  has_many :positions, :dependent => :destroy
  has_many :employees, :dependent => :destroy

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |company|
        csv << company.attributes.values_at(*column_names)
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
