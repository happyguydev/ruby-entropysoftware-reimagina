class Proccess < ActiveRecord::Base
    resourcify
    
    belongs_to :order
    belongs_to :proc_type
    has_many :proccess_instruments, :dependent => :delete_all
    has_many :instruments, :through => :proccess_instruments
    after_create :create_status, :update_status
    after_update :update_status
    after_destroy :update_status
    
    attr_accessor :fecha_cuota
    attr_accessor :cuotas

    def create_status
        OrderStatus.create(:status_type_id => 2, :order_id => self.order_id, :comentario => "Proceso #"+self.proc_type.nombre+" creado")
    end

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
