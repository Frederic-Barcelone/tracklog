class User < ActiveRecord::Base
  has_secure_password

  has_many :logs
  has_many :tracks, :through => :logs

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :distance_units, :inclusion => { :in => [:imperial, :metric] }, :unless => lambda { |s| s.blank? }

  attr_protected :is_admin

  def display_name
    self.name.blank? ? self.username : self.name
  end

  def distance_units
    attributes["distance_units"].try(:to_sym) || Bikelog::Config.distance_units
  end
end