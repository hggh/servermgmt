require 'digest/sha1'

class User < ActiveRecord::Base
  default_scope :order => :username
  validates_presence_of :username
  validates_length_of :username, :minimum => 5, :maximun => 20
  validates_uniqueness_of :username
  validates_confirmation_of :password
  attr_accessor :password, :password_confirmation
  
  attr_protected :id, :passwd

  def self.authenticate(login, pass)
    return nil if pass == ''
    u = find(:first, :conditions =>["username = ? AND active = 1", login])
    if u and User.encrypt(pass) == u.passwd
      return u
    end
    nil
  end
  
  def cookie_remember
    id.to_s + "::" + User.encrypt(username + passwd)
  end
  
  def self.cookie_checkauth(cpasswd)
    u = find(:first, :conditions => ["id = ? AND active = 1", cpasswd.split('::')[0].to_i])
    if u and u.cookie_remember == cpasswd
      return u
    end
    nil
  end
  

  def password=(pass)
    @password=pass
    self.passwd = User.encrypt(@password)
  end

  protected
  
  def self.encrypt(pass)
    Digest::SHA1.hexdigest(pass)
  end

end
