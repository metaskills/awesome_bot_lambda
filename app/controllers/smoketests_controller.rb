class SmoketestsController < ActionController::Base
  helper_method :logged_in?

  def index
    render
  end

  def login
    if params[:password] == 'password'
      session[:logged_in] = 'true'
    end
    redirect_to smoketests_url
  end

  def logout
    reset_session
    redirect_to smoketests_url
  end

  def cache
    expires_in 10.seconds, public: true
  end

  def exception
    raise 'hell'
  end


  private

  def logged_in?
    session[:logged_in] == 'true'
  end

end
