class ShoppingCartController < ApplicationController
  def index
    @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @hotels = HotelShoppingCart.where(:user_id => session[:user_id])
      @events = EventShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def add_cart
    @cart = ShoppingCart.create(:user_id => params[:user_id], :room_id => params[:room_id])
    @cart.save()
    puts "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
    puts @cart.errors.full_messages
    redirect_to :back, :flash => {:success => 'Added to cart'}
  end

  def remove_from_cart
    @cart = ShoppingCart.where(:user_id => session[:user_id])
    @cart.find_by_room_id(params[:room_id]).destroy
    redirect_to :back, :flash => {:error => 'Removed from cart'}
  end

  def remove_from_cart_event
    @cart = EventShoppingCart.find(params[:id]).destroy
    
    redirect_to :back, :flash => {:error => 'Event removed from cart'}
  end

  def event_add_cart
    edate = (params[:event_date]+'/2018').to_s

    @cart = EventShoppingCart.create(:user_id => params[:user_id], :event_id => params[:event_id], :event_name => params[:event_name], :event_date =>  Date.strptime(edate,"%d/%m/%Y"), :event_cat => params[:event_cat], :rate => params[:event_rate])
    @cart.save
  
    puts @cart.errors.full_messages
    redirect_to :back, :flash => {:success => 'Added to cart'}
  end

  def checkout
    
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
      total = ((HotelShoppingCart.sum('rate') + EventShoppingCart.sum('rate')).round(2))
      if total > 2500
        redirect_to :back, :flash => {:error => 'Somthing went wrong'}
      end
    else
      @current_user = nil
    end
  end

  def make_payment
    total = ((HotelShoppingCart.sum('rate') + EventShoppingCart.sum('rate')).round(2))
    puts params[:cardNumber].delete(' ')
    total = sprintf("%.2f",total)
    puts "=================="
    require 'paypal-sdk-rest'
    user = User.find(session[:user_id])
    # Update client_id, client_secret and redirect_uri
    # PayPal::SDK.configure({
    #   :openid_client_id     => "client_id",
    #   :openid_client_secret => "client_secret",
    #   :openid_redirect_uri  => "http://localhost:3000/"
    # })
    # include PayPal::SDK::OpenIDConnect
    @payment = PayPal::SDK::REST::Payment.new({
          :intent => "sale",
          :payer => {
            :payment_method => "credit_card",
            :funding_instruments => [{
              :credit_card => {
                :type => "visa",
                :number => params[:cardNumber].delete(' '),
                :expire_month => params[:cardExpiry].split('/')[0].delete(' '),
                :expire_year => params[:cardExpiry].split('/')[1].delete(' '),
                :cvv2 => params[:cardCVC].delete(' '),
                :first_name => user.first_name,
                :last_name => user.last_name,
                :billing_address => {
                  :line1 => "52 N Main ST",
                  :city => "Johnstown",
                  :state => "OH",
                  :postal_code => "43210",
                  :country_code => "US" }}}]},
          :transactions => [{
           
            :amount => {
              :total => total,
              :currency => "USD" },
            :description => "This is the payment transaction description." }]})

        # Create Payment and return the status(true or false)
        puts "==============="
        if @payment.create
          puts "done"
          puts @payment.inspect     # Payment Id
          HotelShoppingCart.where(user_id: user.id).destroy_all
          EventShoppingCart.where(user_id: user.id).destroy_all
          redirect_to '/', :flash => {:success => 'Payment Successfull'}
        else
          puts "not deone"
          puts @payment.error  # Error Hash
          redirect_to :back, :flash => {:error => 'Somthing went wrong'}
        end
  end

end
