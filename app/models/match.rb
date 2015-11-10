class Match < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_id, :class_name => "User"
  belongs_to :connection, :foreign_key => :connection_id, :class_name => "User"

  self.primary_keys = :user_id, :connection_id
end
