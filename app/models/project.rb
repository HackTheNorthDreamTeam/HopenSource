class Project < ActiveRecord::Base
  has_many :memberships
	has_many :users, through: :memberships, class_name: 'User', source: :user  
	belongs_to :organization

	after_create :create_binder

	def create_binder

		#Authenticate dat shit!

		@connection = Faraday.new(:url => "https://apisandbox.moxtra.com/oauth/token", :ssl => {:verify => false}) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :json, :content_type => /\bjson$/
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    token_response = @connection.post do |req|
      req.url("/oauth/token")
      req.params =  { client_id: ENV['MOXTRA_CLIENT_ID'],
      								client_secret: ENV['MOXTRA_CLIENT_SECRET'],
      								grant_type: "http://www.moxtra.com/auth_uniqueid",
      								uniqueid: 'O' + id.to_s,
      								timestamp: DateTime.now.strftime('%Q'),
      								firstname: name }
    end

    access_token = token_response.body["access_token"]

    response = @connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.url("/v1/me/binders?access_token=#{access_token}")
      req.body = "{ \"name\": \"name\"}"
    end
    moxtra_binder = response.body["data"]["id"]
    save!
	end
  def authenticate_project
    @connection = Faraday.new(:url => "https://apisandbox.moxtra.com/oauth/token", :ssl => {:verify => false}) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :json, :content_type => /\bjson$/
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    
    token_response = @connection.post do |req|
      req.url("/oauth/token")
      req.params =  { client_id: ENV['MOXTRA_CLIENT_ID'],
                      client_secret: ENV['MOXTRA_CLIENT_SECRET'],
                      grant_type: "http://www.moxtra.com/auth_uniqueid",
                      uniqueid: 'O' + id.to_s,
                      timestamp: DateTime.now.strftime('%Q'),
                      firstname: name }
    end
	 token_response.body["access_token"]
 end
end
