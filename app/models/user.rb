require 'dropbox_sdk'
class User < ActiveRecord::Base
  has_many :memberships
	has_many :projects, through: :memberships, foreign_key: 'user_id', class_name: 'Project', source: :project

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def profile_picture
    client = DropboxClient.new(ENV["DROPBOX_TOKEN"])
    client.get_file("/u#{@user.id}")
  end

  def authenticate_user
    token_response = @connection.post do |req|
      req.url("/oauth/token")
      req.params =  { client_id: ENV['MOXTRA_CLIENT_ID'],
                      client_secret: ENV['MOXTRA_CLIENT_SECRET'],
                      grant_type: "http://www.moxtra.com/auth_uniqueid",
                      uniqueid: 'u' + id.to_s,
                      timestamp: DateTime.now.strftime('%Q'),
                      firstname: name }
    end

    token_response.body["access_token"]
  end
end
