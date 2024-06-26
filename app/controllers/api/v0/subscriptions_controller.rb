class Api::V0::SubscriptionsController < ApplicationController
  before_action :set_customer, only: [:create, :index, :destroy]   
  before_action :set_subscription, only: [:destroy]    
  
  def index     
    subscriptions = @customer.subscriptions     
    render json: SubscriptionSerializer.new(subscriptions).serializable_hash.to_json  
  end   

  def create     
    begin
    tea = Tea.find(subscription_params[:tea_id]) 
    
      subscription = @customer.subscriptions.new(subscription_params)     
      subscription.tea = tea      
      if subscription.save       
        render json: SubscriptionSerializer.new(subscription).serializable_hash.to_json, status: :created     
      else       
        render json: subscription.errors, status: :unprocessable_entity     
      end   
    rescue
      render json: { error: 'Invalid subscription details' }, status: :unprocessable_entity
    end
  end    
  
  def destroy    
    if @subscription.update(status: 'cancelled')       
      render json: SubscriptionSerializer.new(@subscription).serializable_hash.to_json, status: :ok     
    else       
      render json: @subscription.errors, status: :unprocessable_entity    
    end   
  end    
  
  private    

  def set_customer    
    @customer = Customer.find(params[:customer_id])   
  end    
  
  def set_subscription     
    @subscription = @customer.subscriptions.find(params[:id])   
  end    
  
  def subscription_params     
    params.require(:subscription).permit(:title, :price, :status, :frequency, :tea_id)   
  end
end
