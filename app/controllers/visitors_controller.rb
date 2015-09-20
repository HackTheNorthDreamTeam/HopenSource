class VisitorsController < ApplicationController
	def index
		if organization_signed_in?
			redirect_to "/organization/#{current_organization.id}/dash"
		elsif user_signed_in?

		end
	end
end
