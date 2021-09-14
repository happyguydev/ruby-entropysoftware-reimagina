class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :find_lazy, ->(id) { where(:id => id) }

  validates :email, :first_name, :second_name, presence: true

  belongs_to :user_type

  has_many :assigned_schools
  has_many :schools, :through => :assigned_schools

  after_save :assign_user_role

  def full_name
    if first_name or second_name
      return "#{first_name} #{second_name}"
    end
    "Sin nombre"
  end

  def admin?
    self.is_admin?
  end

  def get_roles_in_resource res
    self.roles.where(:resource_id => res.id, :resource_type => res.class.name).map{ |r| r.name.to_sym }
  end

  def has_roles_in_resource? res
    self.get_roles_in_resource(res).length > 0
  end

  def has_school_client_role?
    eval(%w(daem cobranza director profesor utp).map{ |role| self.has_role? role }.join(' || '))
  end

  def has_access? roles
    eval(roles.map{ |role| self.has_role? role }.join(' || '))
  end

  def self.with_client_roles
    with_any_role(:daem, :cobranza, :director, :profesor, :utp)
  end

  private
    def assign_user_role
      if !self.try(:user_type_id).nil?
        user_role = self.user_type.code.downcase.to_sym
        self.add_role(user_role)
      end
    end
end
