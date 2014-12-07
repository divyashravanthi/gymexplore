module ApplicationHelper
	def resource_name
    :agency
  end
 
  def resource
    @resource ||= Agency.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:agency]
  end
end
