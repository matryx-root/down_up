class UsersController < ApplicationController

  def index
    @users = policy_scope(User).order(created_at: :desc)
            # if current_user.has_any_role? :admin :newuser

            # else
            # redirect_to root_path, alert: 'not authorized'
            # end
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to users_url, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end



  private
    def user_params
      params.require(:user).permit({role_ids: []})
    end
end
