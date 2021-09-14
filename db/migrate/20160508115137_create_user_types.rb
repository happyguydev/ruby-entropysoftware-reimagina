class CreateUserTypes < ActiveRecord::Migration
	def migrate(direction)
		super
		
		UserType.create([
			{ name: "Administrador", role: "admin", code: "ADMINISTRADOR", is_active: true },
			{ name: "General", role: "admin", code: "GENERAL", is_active: true },
			{ name: "Recaudación", role: "admin", code: "RECAUDACION", is_active: true },
			{ name: "Evaluación", role: "admin", code: "EVALUACION", is_active: true },
			{ name: "Pruebas", role: "admin", code: "PRUEBAS", is_active: true }
		])
	end
	
  	def change
    	create_table :user_types do |t|
      		t.string :name
      		t.string :role
      		t.string :code
      		t.boolean :is_active

      		t.timestamps null: false
    	end
  	end
end
