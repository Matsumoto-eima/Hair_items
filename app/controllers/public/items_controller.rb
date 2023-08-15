class Public::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to item_path(@item), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    item = Item.find(params[:id])
  unless item.user.id == current_user.id
    redirect_to items_path
  end
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render "edit"
    end
  end

  def show
    @item = Item.find(params[:id])
    @item_comment = ItemComment.new
  end

  def index
      @items = Item.all
      @item_new = Item.new
      @user = current_user
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

   private

  def book_params
    params.require(:item).permit(:name, :description, :image)
  end
end
