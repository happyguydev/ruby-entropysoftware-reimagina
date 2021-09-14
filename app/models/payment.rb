class Payment < ActiveRecord::Base
  resourcify
  
  after_create :create_status, :create_paydate, :update_status
  after_update :create_paydate, :update_status
  after_destroy :update_status
  belongs_to :order

  def create_status
    status = StatusType.where(:short_name => 'pago').first
      OrderStatus.create(:status_type_id => status.id, :order_id => self.order_id, :comentario => "Pago por "+self.monto.to_s)
  end

  def create_paydate
      order = self.order 
      paydate = order.try(:payments).where(:paid => [nil, false]).order(:fecha).first.try(:fecha)
      order.paydate = paydate
      order.save
  end

  def update_status
  	order = self.order
    facturado = order.try(:invoices).sum('invoices.monto')
    cobrado = order.try(:proccesses).sum('proccesses.monto')
    pagado = order.try(:payments).where('payments.paid = true').sum('payments.monto')

   if(cobrado == pagado)
    status = PayStatus.where(:short_name => 'pagado').first
    else
        if(facturado == cobrado)
            status = PayStatus.where(:short_name => 'facturado').first
        else
            status = PayStatus.where(:short_name => 'proceso').first
        end
   end
   order.pay_status = status
   order.save
  end

  def self.generate_cuotas(order,proccess,monto,cuotas,fecha)
    
    #### PENDING ; NEED TO MOVE TO ANOTHER VIEW AND OPTIMIZE 
#    cuotas = cuotas.to_i if cuotas.class.name == 'String'
#    fecha = fecha.to_date if fecha.class.name == 'String'
#
#    if cuotas > 0
#      monto = monto/cuotas
#      cuotas.times do |i|
#        fecha_cuota = fecha + i.month
#        Payment.create(:order_id => order, :monto => monto, :fecha => fecha_cuota, :comentario => "Cuota #{(i+1)} de #{cuotas} #{proccess}")
#      end
#    end
  end

end

