class Api::V1::UsersController < ApplicationController

	before_action :authenticate_api_v1_user!
  before_action :check_existing_user, only: [:invite_user]
  before_action :get_referal_bonus, only: [:invite_user]


  # get "/api/v1/users"
  # User for about us page
	def index 
	  @users = User.limit(4)
    if @users.present?
      render_collection(@users, 'user', User, "users list...!")
    else
      render_error("Not avalable user...!")
    end
  end

	# post /api/v1/reset_password
  def reset_password
    if current_api_v1_user.present? 
      if (params[:user][:new_password]) == (params[:user][:confirm_password])
        if current_api_v1_user.update(password: params[:user][:new_password]) and current_api_v1_user.errors.blank?
        	render json: {success: true, user: current_api_v1_user.as_json, message: "Password Changed Successfully "}
        else
        	render json: {success: false, error: current_api_v1_user.errors.messages}
        end	
      else
        render json: {success: false, message: "New Password does not match - Confirm Password"}
      end
    else
      render_error("Sign in first")
    end
  end

   # get /api/v1/users/user_details
  def user_details
    if current_api_v1_user.present?
      date_joined = current_api_v1_user.created_at.to_date
      tickets_analyzed = current_api_v1_user.user_analyzed_trades.count
      render json: {success: true, user: current_api_v1_user.as_json.merge({date_joined: date_joined,tickets_analyzed: tickets_analyzed}), message: "User details."}
    else
      render_error("Sign in first")
    end
  end

  # POST /api/v1/set_news_letter
  def set_news_letter
    if current_api_v1_user.present? 
      if params[:user][:email].present?
        user = User.find_by_email params[:user][:email]
        if user.present? 
          unless user.news_letter
            if user.update(news_letter: true) and user.errors.blank?
              render json: {success: true, message: "Successfully subscribed."}
            else
              render json: {success: false, message: user.errors.messages}
            end
          else
            render json: {success: false, message: "You have already subscribed"}
          end
        else
          render json: {success: false, message: "user not found with this email."}
        end
      else
        render json: {success: false, message: "Please enter email id."}
      end
    else
      render_error("Sign in first")
    end
  end

  # post  /api/v1/set_analyzed_trades
  def set_user_analyzed_trades
    if current_api_v1_user.present? and current_api_v1_user.subscribed?
      unless UserAnalyzedTrade.where("user_id =? and today_trade_id = ?",current_api_v1_user.id,params[:trade_analyzed][:today_trade_id]).present?
        @analyzed_trades = UserAnalyzedTrade.new(today_trade_id: params[:trade_analyzed][:today_trade_id],current_rate: params[:trade_analyzed][:current_rate],user_id: current_api_v1_user.id)
        if @analyzed_trades.save
          render json: {success: true, message: "Analyzed Trades Successfully"}, status: 200
        else
          render json: {success: true, message: @analyzed_trades.errors.messages}
        end
      else
        render json: {success: false, message: "You already analyzed this trade"}
      end
    else
      render_error("Sign in first")
    end
  end

  def similar_profile
    if current_api_v1_user.present?
      similar_user = User.similar_profiles(current_api_v1_user)
      if similar_user.present?
        render_collection(similar_user, 'similar_user', User, "similar_profiles users...!")
      else
        render_error("Currently not avalable similar_profiles users...!")
      end
    else
      render_error("Sign in first")
    end
  end
  
  # GET /api/v1/get_user_analyzed_trades
  def get_user_analyzed_trades
    if current_api_v1_user.present?
      @user_analyzed_trades = current_api_v1_user.user_analyzed_trades
      if @user_analyzed_trades.present?
        data_hash={}
        data_array = []
        @user_analyzed_trades.each_with_index do |d,i|
          symbol = d.today_trade.company.symbol
          company_details = FinnhubApi::fetch_company_profile symbol
          current_rate = FinnhubApi::fetch_company_rate symbol
          expected_rate = d.today_trade.company.expected_rate
          day_gain_or_loss, gain_or_loss_per, status = calculate_day_gain current_rate, expected_rate, status
          data = {logo: company_details["logo"],trade_id: d.today_trade.id, company_id: d.today_trade.company.id , symbol: d.today_trade.company.symbol, name: d.today_trade.company.name, current_rate: current_rate, expected_rate: expected_rate, day_gain_or_loss: day_gain_or_loss, gain_or_loss_per: "#{gain_or_loss_per}%", status: status }
          data_array << data
          # data_hash["analyzed_trade_#{i+1}"] = data
        end
        render json: {success: true, message: "Analyzed Trades" , data: data_array }
      else
        render json: {success: false, message: "Not Analyzed any trade yet.."}
      end
    else
      render_error("Sign in first")
    end
  end

  def invite_user
    if current_api_v1_user.present?
      @user = current_api_v1_user
      email = params[:email]
      if @existing_user.present?
        render_error("User alredy exist !")
      else
        UserMailer.invite(@user, email, @referal_bonus).deliver
        render json: {success: true, message: "Invite user link sent to your email" }, status: 200
      end
    else
      render_error("Sign in first")
    end
  end

  def wallet
    if current_api_v1_user.present?
      if current_api_v1_user.wallet.present?
        wallet = current_api_v1_user.wallet
        render_object(wallet, 'wallet', "User wallet..!")
      else
        render_error("Currently not create wallet")
      end
    else
      render_error("Sign in first")
    end
  end

  private

  def calculate_day_gain current, expected, status = nil
    if expected < current
      gain = (current - expected)
      gain_per = (gain*100/expected)
      return gain.round(2) , gain_per.round(2), "Gain"
    else
      loss = (expected - current).abs
      loss_per = (loss*100/expected)
      return loss.round(2) , loss_per.round(2), "Loss"
    end
  end


  def check_existing_user
    @existing_user = User.find_by(email: params[:email])
  end

  def get_referal_bonus
    @referal_bonus = ReferralBonus.find_by(active: true)
  end

end
