class Api::V1::UsersController < ApplicationController

	before_action :authenticate_api_v1_user!

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

  def user_details
    if current_api_v1_user.present?
      render json: {success: true, user: current_api_v1_user.as_json, message: "User details."}
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
    if current_api_v1_user.present?
      @analyzed_trades = UserAnalyzedTrade.new(today_trade_id: params[:trade_analyzed][:today_trade_id],current_rate: params[:trade_analyzed][:current_rate],user_id: current_api_v1_user.id)
      if @analyzed_trades.save
        render json: {success: true, message: "Analyzed Trades Successfully"}, status: 200
      else
        render json: {success: true, message: @analyzed_trades.errors.messages}
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
        @user_analyzed_trades.each_with_index do |d,i|
          symbol = d.today_trade.company.symbol
          company_details = FinnhubApi::fetch_company_profile symbol
          current_rate = FinnhubApi::fetch_company_rate symbol
          data = {logo: company_details["logo"], symbol: d.today_trade.company.symbol, name: d.today_trade.company.name, current_rate: current_rate, day_gain: "0" }
          data_hash["analyzed_trade_#{i+1}"] = data
        end
        render json: {success: true, message: "Analyzed Trades" , data: data_hash }
      else
        render json: {success: false, message: "Not Analyzed any trade yet.."}
      end
    else
      render_error("Sign in first")
    end
  end

end
