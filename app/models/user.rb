require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :username
  validates_length_of :username, :minimum => 6, :maximun => 20
  validates_uniqueness_of :username
  validates_confirmation_of :password
  attr_accessor :password, :password_confirmation
  
  attr_protected :id, :passwd

  def self.authenticate(login, pass)
    u = find(:first, :conditions =>["username = ? AND active = 1", login])
    return nil if u.nil?
    return u if User.encrypt(pass)==u.passwd
    nil
  end
  
  def cookie_remember
    id.to_s + "::" + Digest::SHA1.hexdigest(username + passwd)
  end
  
  def self.cookie_checkauth(cpasswd)
    u = find(:first, :conditions => ["id = ? AND active = 1", cpasswd.split('::')[0].to_i])
    if u and u.cookie_remember == cpasswd
      return true
    end
    nil
  end
  

#  def passwd=(pass)
#
#  end

  protected
  
    def self.encrypt(pass)
      Digest::SHA1.hexdigest(pass)
    end

end
