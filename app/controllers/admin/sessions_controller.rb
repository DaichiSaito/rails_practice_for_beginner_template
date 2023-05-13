class Admin::SessionsController < Admin::BaseController
    skip_before_action :require_admin, only: [:new, :create]
    layout false
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to admin_questions_path, notice: 'ログインしました。'
        else
            render :new
        end
    end
end
