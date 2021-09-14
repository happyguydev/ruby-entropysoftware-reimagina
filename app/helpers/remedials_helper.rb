module RemedialsHelper

  def assignature_options
    Assignature.all.collect{|assign| [assign.nombre, assign.id] }.unshift(['Seleccione una opcion', nil])
  end
end
