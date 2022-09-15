class Admin::SoftwaresController < ApplicationController
  def index
    @softwares = Software.all
    @software = Software.new
  end

  def create
    @software = Software.new(software_params)
    @software.save
    redirect_to admin_softwares_path
  end

  def edit
    @software = Software.find(params[:id])
  end

  def update
    @software = Software.find(params[:id])
    @software.update(software_params)
    redirect_to admin_softwares_path
  end
  def destroy

    redirect_to admin_softwares_path
  end
  private

  def software_params
    params.require(:software).permit(:software)
  end
end
