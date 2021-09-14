class Invoice < ActiveRecord::Base
	resourcify

	validates :monto, :numericality => { :greater_than_or_equal_to => 0 }
	validates :fecha, presence: true
	validates :numero, :numericality => { :greater_than_or_equal_to => 0 } 
	belongs_to :order
	after_create :create_status, :update_status
	after_update :update_status
	after_destroy :update_status

	def create_status
      status = StatusType.where(:short_name => 'fc').first
      order = self.order
      OrderStatus.create(:status_type => status, :order_id => order.id, :comentario => "Factura #"+self.numero.to_s+" creada")
      order.status_type_id = status.id
      order.save
 	 end

	has_attached_file :document, styles: {thumbnail: "60x60#"}
	validates_attachment :document, content_type: { content_type: "application/pdf" }


  def update_status
  	order = self.order
    facturado = order.try(:invoices).sum('invoices.monto')
    cobrado = order.try(:proccesses).sum('proccesses.monto')
    pagado = order.try(:payments).where('payments.paid = true').sum('payments.monto')
    status_id  = PayStatus.where(:short_name => 'proceso').first.id

   if(cobrado == pagado)
    status_id = PayStatus.where(:short_name => 'pagado').first.id
    else
        if(facturado == cobrado)
            status_id = PayStatus.where(:short_name => 'facturado').first.id
        else
            status_id = PayStatus.where(:short_name => 'proceso').first.id
        end
   end
    order.pay_status_id = status_id
    order.save
  end    

end
