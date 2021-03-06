# coding: utf-8
module SessionsHelper

  # 登入指定的用户
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user

    # 如果session中有用户id 则从中取回用户;否则，检查cookies[:user_id],取回并登入持久会话中的用户
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    
  end

  # 如果用户已登录，返回 true，否则返回 false
  def logged_in?
     !current_user.nil?
  end

  def log_out
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 在持久会话中记住用户
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
