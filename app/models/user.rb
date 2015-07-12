class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :wikis
  after_initialize :init 

  def init
    self.role ||= 'standard'
  end

  def admin?
    self.role =='admin'
  end

  def premium?
    self.role == 'premium'
  end

end
