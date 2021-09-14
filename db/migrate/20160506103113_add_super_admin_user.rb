class AddSuperAdminUser < ActiveRecord::Migration
	def migrate(direction)
		super
		
		user = User.create(
			email: "super@reimagina.cl", password: '12345678', 
			password_confirmation: '12345678', 
			first_name: "Super", second_name: "Admin"
		)

		user.add_role(:super)
	end

  	def change
  	end
end
