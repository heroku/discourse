class Auth::HerokuUserProvider < Auth::DefaultCurrentUserProvider

  def has_auth_cookie?
    request = Rack::Request.new(@env)
    logged_in?(request) || logging_in?(request)
  end

  def logged_in?(request)
    @request.cookies['heroku_session'].present? || @request.cookies['heroku_session_nonce'].present?
  end

  def logging_in?(request)
    request.path.to_s.starts_with?('/auth')
  end

end

Discourse.current_user_provider = Auth::HerokuUserProvider