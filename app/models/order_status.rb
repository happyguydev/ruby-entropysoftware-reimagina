class OrderStatus < ActiveRecord::Base
  resourcify
  
  belongs_to :order
  belongs_to :status_type
  after_create :update_order

  def update_order
  	order = self.order
  	order.status_type = self.status_type
  	order.save
  end

  
end
