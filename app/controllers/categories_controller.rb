class CategoryController < ApplicationController

  before_action :confirmed_signed_in
  before_action :confirm_id, only: [:show, :edit, :update, :destroy]
  # TODO: confirm user is admin

  def index
    @categories = Category.sorted
  end

  def show
    @category = Category.find_by_id(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Successfully Created Category"
      redirect_to(action: "show", id: @category.id)
    else
      render("new")
    end
  end

  def edit
    @category = Category.find_by_id(params[:id])
  end

  def update
    @category = Category.find_by_id(params[:id])

    if @category.update_attributes(category_params)
      flash[:success] = "Category Updated Successfully"
      redirect_to(action: "show", id: @category.id)
    else
      render("edit")
    end
  end

  def destroy
    Category.find_by_id(params[:id]).destroy
    flash[:success] = "Category Deleted Successfully"
    redirect_to( action: "index" )
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
