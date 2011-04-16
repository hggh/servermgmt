require 'rexml/document'


class SshPublicKeysController < ApplicationController
  skip_before_filter :login_required, :only => [ 'getKeys' ]
  before_filter :access, :on => 'getKeys'
  
  def getKeys
    server = Server.find_by_fqdn(params[:fqdn])
    xml = REXML::Document.new("<?xml version='1.0'?>")
    sshusers = Sshuser.includes(:server, :server_group).where('server_id = ? OR server_group_id IN (?)', server.id, server.getServerGroupIds)
    server_xml = xml.add_element "server", { "name" => server.fqdn }
    sshusers.each do|shu|
      user_xml = server_xml.add_element "username", { "name" => shu.username }
      public_keys = Array.new
      shu.sshuser_mbrs.each do |member|
        if member.sshkey_id
          public_keys << member.sshkey.key_public_auth
        else
          public_keys = public_keys + member.sshkey_group.getKeysFromMembers
        end
      end
      public_keys.each do |k|
        key = user_xml.add_element "key"
        key.add_text k
      end
    end
    
    respond_to do |format|
      format.xml { render :xml => xml}
    end
    
    
  end
  
  def access
    raise "Secret Missing" if Setting.get('puppet_secret_sshkeys').to_s == ''
    if params[:secret] and params[:secret] == Setting.get('puppet_secret_sshkeys').to_s
      return true
    end
    raise "Secret Missing"
  end
end
