class ReportsBypass < ActiveRecord::Base
	resourcify
  has_attached_file :report
  validates :report, :attachment_presence => true
  do_not_validate_attachment_file_type :report
end
