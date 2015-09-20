class OrganizationsController < ApplicationController
	def index
		@organization = Organization.find(params[:id])
	end
end
