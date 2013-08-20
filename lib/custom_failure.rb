class CustomFailure < Devise::FailureApp

  def redirect_url
    if warden_options[:scope] == :account
      session[:previous_url] || new_account_registration_path
    else
      session[:previous_url] || new_account_registration_path
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end