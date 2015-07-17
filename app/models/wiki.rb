class Wiki < ActiveRecord::Base
  belongs_to :user
  default_scope { order('id DESC') }
  scope :visible_to, -> (user) { user ? all : where(private: false) }
end
