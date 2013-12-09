class UserMailer < Devise::Mailer
  
  def project_update(record, opts={})
    devise_mail(record, :project_update, opts)
  end
end