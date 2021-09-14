class AddReportGeneratedToProccessInstrument < ActiveRecord::Migration
  def change
    add_column :proccess_instruments, :report_generated, :boolean, default: false
  end
end
