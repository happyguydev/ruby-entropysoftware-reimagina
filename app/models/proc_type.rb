class ProcType < ActiveRecord::Base
  resourcify
  belongs_to :proc_type_father
end
