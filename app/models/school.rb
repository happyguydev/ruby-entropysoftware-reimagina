class School < ActiveRecord::Base
  mount_uploader :logo, LogoUploader
  resourcify
  has_many :grades, :dependent => :delete_all
  has_many :orders, :dependent => :delete_all
  attr_accessor :region
  belongs_to :commune
  validate :logo_size_validation

  #belongs_to :assigned_school
  has_many :assigned_schools
  has_many :users, :through => :assigned_schools
  accepts_nested_attributes_for :users, reject_if: :all_blank, allow_destroy: true

	validates :nombre, :rut, :direccion, :telefono,
		:rbd, :dependencia, presence: true

  def self.list
    School.all.map{|school| [school.nombre, school.id] }
  end


  def logo_size_validation
        #errors[:image] << "should be less than xMB" if image.size > 1.megabytes
        #add the following code instead of above line
      if self.logo.size > 1.megabytes
       # errors.add[:logo] << "should be less than 1MB" if logo.size > 1.megabytes
       #flash[:notice] = "should be less than 1MB"
       errors.add(:logo,"debe ser inferior a 1 MB")
      end

    end
end
