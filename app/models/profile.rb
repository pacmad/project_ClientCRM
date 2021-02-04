class Profile < ApplicationRecord
  attr_accessor :make_user

  belongs_to :user
  belongs_to :country
  belongs_to :client_status
  belongs_to :group
  belongs_to :group_position
  belongs_to :team_project
  belongs_to :team_position

  default_scope { order(surname: :desc) }

end
