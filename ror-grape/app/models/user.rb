class User < ActiveRecord::Base
  before_save :encrypt_password
  def encrypt_password  
    self.password = Digest::SHA2.hexdigest(self.password)  
  end 
  
  def authorized? password  
    Digest::SHA2.hexdigest(password) == self.password  
  end
end
