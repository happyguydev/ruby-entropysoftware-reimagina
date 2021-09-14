namespace :client_user do
  desc "client"
  task :roles => :environment do
    Role.where(name: 'client').first_or_initialize.save
    %w(daem cobranza director profesor utp).each do |role|
      UserType.where(code: role.upcase).first_or_initialize(name: role.capitalize, role: 'client', is_active: true).save
    end
  end
end

namespace :answer do
  desc "Student answers"
  task :update_status => :environment do
    # Answer.all.map{|ans| ans.update(correct: (ans.letra == ans.question.try(:guide).try(:alternative_index)))}
    Answer.all.map{ |ans| ans.update(correct: ans.proccess_instrument.instrument.guides.where(question_id: ans.question_id).last.alternative_index == ans.letra) } 
  end
end
# run => rake client_user:roles
# run => rake answer:update_status