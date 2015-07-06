class BoletosController < ApplicationController
  before_action :require_login

  def index
    @boletos_receiveid = Boleto.to_user(current_user)
    @boletos_sent = Boleto.from_user(current_user)
  end

  def new
    @sendable_users = current_user.sendable_customers
  end

  def create
    binding.pry
    sendable_user = User.find(params[:user][:id])
    sendable_user.boletos.create(boleto_params)
    redirect_to action: "index"
  end

  def show
  end

  def destroy
    Boleto.destroy(params[:id])
    redirect_to action: "index"
  end

  private
  def boleto_params
    params.require(:boleto).permit(:due_date, :sender_origin_email)
  end
end