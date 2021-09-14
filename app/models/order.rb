class Order < ActiveRecord::Base
  resourcify
  has_many :order_statuses, :dependent => :delete_all
  has_many :invoices, :dependent => :delete_all
  has_many :buy_orders, :dependent => :delete_all
  has_many :proccesses, :dependent => :delete_all
  accepts_nested_attributes_for :proccesses, :reject_if => :all_blank, :allow_destroy => true
  has_many :payments, :dependent => :delete_all
  has_one :feedback,  :dependent => :destroy
  belongs_to :school
  after_create :create_status
  belongs_to :service_type
  belongs_to :payer_type
  belongs_to :pay_status
  belongs_to :status_type
  validates :school_id, presence: true

  def create_status
      status = StatusType.where(:short_name => 'oc').first
      OrderStatus.create(:status_type => status, :order_id => self.id, :comentario => "Orden #"+self.number.to_s+" creada")
      self.status_type_id = status.id
      self.pay_status = PayStatus.where(:short_name => 'proceso').try(:first)
      self.save
  end

  def to_label
    school.nombre
  end

  def last_status
    self.order_statuses.last.status_type.nombre
  end
end