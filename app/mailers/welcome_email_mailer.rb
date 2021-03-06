class WelcomeEmailMailer < ApplicationMailer
  default from: 'info@kingdomsg.com'
  # default from: 'contact@kingdomsg.com'
  def welcomeemail(user)
    @greeting = "Hi"
    @user = user
    mail :to => user.email, :subject => " Account Activation – Kingdom Sports Group "

  end

  def shoppingdetails(cart,freight,cc_amount ,user, total)
    @cart  = cart
    @user = user
    @freight = freight
    @cc_amount = cc_amount
    @total = total
    # admin_shopping_cart(@cart, @user)
    mail :to => user.email, :subject => "Thank you for your order"
  end

  def rate_exteted(cart,freight,cc_amount, user,total)
    @cart = cart
    @user = user
    @freight = freight
    @cc_amount = cc_amount
    @total = total
    # admin_rate_exteted(@cart ,@user)
    mail :to => user.email, :subject => " Your order is registered over $2,500 and will be actioned by Kingdom Sports Group"

    # mail to: => "", :subject => "Payment exteded of user"
  end

  def complete_subscription(email)
    ig_email =  email
    @t_email = email
    @t_email = @t_email.gsub('.','$')
    puts "======================="

    puts ig_email
    mail :to => ig_email, :subject => "Thank you for subscribing"
  end

  def admin_rate_exteted(cart,freight,cc_amount,user,total)
    @cart = cart
    @user = user
    @freight = freight
    @cc_amount = cc_amount
    @total = total
    mail :to => "info@kingdomsg.com", :subject => "A customer has placed an order over $2500"
    # info@kingdomsg.com
  end

  def admin_shopping_cart(cart,freight,cc_amount, user, total)
    @cart = cart
    @user = user
    @freight = freight
    @cc_amount = cc_amount
    @total = total
    mail :to => "info@kingdomsg.com", :subject => "User shopping cart details"
  end

  def subscribed_welcome_user(email)
    @email_subscribed = email
    mail :to => @email_subscribed, :subject => "Thank you for subscription"
  end

end
