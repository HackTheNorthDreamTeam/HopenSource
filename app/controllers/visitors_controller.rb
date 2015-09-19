class VisitorsController < ApplicationController
	def index
		if organization_signed_in?

		elsif user_signed_in?

		end
	end
end
