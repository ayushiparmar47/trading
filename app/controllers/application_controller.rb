class ApplicationController < ActionController::Base
 	
	skip_before_action :verify_authenticity_token
 	protect_from_forgery with: :null_session
	serialization_scope :view_context
 	
 	def render_object(object, key_name, message, additaional_options = {})
		serializer_name = "#{object.class.name}Serializer".constantize
		object_name = object.class.name.downcase
		if object
		  render json: {
		    message: message, success: true,
		    key_name.to_sym =>  serializer_name.new(object, scope: current_api_v1_user)
		  }.merge!(additaional_options),
		  status: :ok
		else
		  render json: {
		    message: message, success: true,
		     key_name.to_sym =>  {}
		  }.merge!(additaional_options),
		   status: :ok
		end
	end

	def render_collection(collection, key_name, model, message, additaional_options = {})
    serializer_name = "#{model.name}Serializer".constantize
    object_name = model.name.downcase
    render json: {
      message: message, success: true,
      data: {
        object_name.to_sym => collection_serializer.new(collection, serializer: serializer_name, scope: current_api_v1_user)
      }.merge!(additaional_options)
    },
    status: :ok
	end

	def render_destroy(message)
	  render json: {
	    message: message, success: true
	  },
	  status: :ok
	end
  
  def render_error(message)
	  #render json: { message: message,success: false }, status: :unprocessable_entity
	  render json: { message: message, success: false }, status: :ok
	end
    
  def collection_serializer
	  ActiveModel::Serializer::CollectionSerializer
	end
    
end
