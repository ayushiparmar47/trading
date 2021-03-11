class Api::V1::RegistrationsController < Devise::RegistrationsController

  before_action :authenticate_api_v1_user!, only: [:edit,:update]
  before_action :set_referrer, only: [:create]
  
  # POST /api/v1/users
  def create
    user = User.new(email: params[:email], first_name: params[:first_name], image: params[:image], short_bio: params[:short_bio], password: params[:password], trading_exp: params[:trading_exp])
    if @referrer.present? || params[:referrer_key]&.present? == false || params[:referrer_key].nil?
      user.referrer_id = @referrer.id if @referrer.present?
      if user.save
        token = Tiddle.create_and_return_token(user, request)
        UserMailer.accept(@referrer, user).deliver if @referrer.present?
        plan_id = params[:plan_id]
        @subscription = user.subscriptions.new(plan_id: plan_id)
        if plan_id.present?
          @plan = Plan.find_by(id: plan_id)
          if @plan.amount == 0.0
            @subscription.save
          else
            token = params[:stripeToken]
            if token.present?
              stripe = StripeBaseClass.new(token, user, "card", @plan.id)
              charge = stripe.charge
              if charge.paid? && charge.status == "succeeded"
                payment = user.payments.create(amount: @plan.amount, stripe_charge_id: charge.id, payment_source: "card", status: charge.status)
                stripe_subscription = stripe.create_subscription
                @subscription.stripe_charge_id = charge.id
                if @subscription.save
                  user.update(subscribed: true)
                end
              end
            end   
          end
        end
        #render json: { success: true, user: user.as_json.merge({token: token}), message: "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."} 
        render_object(user, 'user', "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.", token: token)     
      else
        msg = user.errors.full_messages
        render json: {success: false, message: msg}
      end
    else
      render json: {success: false, message: "Invalid referral code...!"}
    end  
  end

  # GET /api/v1/users/edit
  def edit
    if current_api_v1_user.present?
      render_object(current_api_v1_user, 'user', "Edit user details.")
    else
      render_error("Sign in first")
    end
  end

  # PUT /api/v1/users
  def update
    if current_api_v1_user.present?
      current_api_v1_user.update(email: params[:email], first_name: params[:first_name], image: params[:image], short_bio: params[:short_bio])
      if current_api_v1_user.errors.messages.blank?
        if current_api_v1_user.email != params[:email]
          render_object(current_api_v1_user, 'user', "Since you have changed your email, a confirmation mail has been sent to your updated mail id. Please confirm it before proceed.")
        else
          render_object(current_api_v1_user, 'user', "Successfully updated user details.")
        end
      else
        render json: {success: false, user: current_api_v1_user, message: current_api_v1_user.errors.messages}, status: 404
      end
    else
      render json: {success: false, user: current_api_v1_user, message: current_api_v1_user.errors.full_messages.to_sentence}, status: 404
    end
  end

  protected

  def set_referrer
    @referrer = User.find_by_referral_code(params[:referrer_key]) if (params[:referrer_key]).present?
  end

end
