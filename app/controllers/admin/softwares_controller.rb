class Admin::SoftwaresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @softwares = Software.all
    @software = Software.new
  end

  def create
    @software = Software.new(software_params)
    if @software.save
      redirect_to admin_softwares_path
    else
      flash.now[:alret] = "未入力の箇所があります"
      render :index
    end
  end

  def edit
    @software = Software.find(params[:id])
  end

  def update
    @software = Software.find(params[:id])
    @software.update(software_params)
    if @software.save
      redirect_to admin_softwares_path
    else
      flash.now[:alret] = "ソフト名を入力してください"
      render :edit

  end end
  def destroy
    @software = Software.find(params[:id])
    @software.destroy
    redirect_to admin_softwares_path
  end
  private
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  admin_session_path
    end
  end
  def software_params
    params.require(:software).permit(:name)
  end
end
