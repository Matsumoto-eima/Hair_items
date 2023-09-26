class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]

  def show
    @user = User.find(params[:id])
    @items = @user.items
    @item = Item.new
  end

  def edit
    user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to current_user
  end
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def withdraw
      @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_quit_status: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def check
  end

  def user_params
    params.require(:user).permit(:name)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
