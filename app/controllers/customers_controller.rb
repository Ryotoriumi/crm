class CustomersController < ApplicationController
  before_action  :set_customer, only: [:show, :update, :edit, :destroy]
  before_action :set_company, only: [:new, :edit]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #@customers = Customer.all
    @customers = Customer.page(params[:page]) # using kaminari
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @customer.destroy
    redirect_to customers_url
  end

private

def set_customer
  @customer= Customer.find(params[:id])
end

def set_company
    @companies = Company.all
end

def customer_params
  params.require(:customer).permit(:family_name, :given_name, :email, :company_id)
end

end
