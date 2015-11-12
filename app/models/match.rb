class Match < ActiveRecord::Base
  searchkick
  belongs_to :user
  belongs_to :connection, :foreign_key => :connection_id, :class_name => :User

  self.primary_key = :user_id, :connection_id

  def self.combined_matches(user_id)
    @combined_matches = []
    where(user_id: user_id.id, active: true).each do |match|
      @combined_matches << match
    end

    where(connection_id: user_id.id, active: true).each do |match|
      @combined_matches << match
    end
    @combined_matches
  end

end
