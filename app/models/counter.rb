class Counter < ApplicationRecord
  include Hashid::Rails
  
  belongs_to :created_from_ip, :class_name => "Ip"
  belongs_to :incremented_from_ip, :class_name => "Ip"
  
  validates_uniqueness_of :name
  validates_length_of :name, maximum: 100
  validates :value, numericality: {less_than_or_equal_to: MAX_VALUE, only_integer: true}
  
  before_create :init_password
  
  def inc!
    return self.increment!(:value).value
  end
  
  def get_url
    return "/counter/#{self.name}"
  end
  
  
  private
  
  def init_password
    self.password ||= SecureRandom.hex
  end
end
