class User < ActiveRecord::Base
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

end
