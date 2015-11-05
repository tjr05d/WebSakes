class Match < ActiveRecord::Base
  belongs_to :first_selector, :class_name => :User
  belongs_to :second_selector, :class_name => :User
end
