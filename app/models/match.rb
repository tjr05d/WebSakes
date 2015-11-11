class Match < ActiveRecord::Base
  belongs_to :user
  belongs_to :connection, :foreign_key => :connection_id, :class_name => :User
end
