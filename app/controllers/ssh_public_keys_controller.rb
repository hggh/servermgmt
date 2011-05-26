require 'rexml/document'


class SshPublicKeysController < ApplicationController
  skip_before_filter :login_required, :only => ['getKeys']
  before_filter :access, :on => 'getKeys'

  def getKeys
    server = Server.find_by_fqdn(params[:fqdn])
    xml = REXML::Document.new("<?xml version='1.0'?>")
    if server
      sshusers = Sshuser.includes(:server, :server_group).where("server_id = #{server.id} OR server_group_id IN (#{server.getServerGroupIds.join(',')})")
      server_xml = xml.add_element "server", {"name" => server.fqdn}

      mykeys = Hash.new
      sshusers.each do |shu|
        if !mykeys[shu.username].kind_of?(Array)
          mykeys[shu.username] = Array.new
        end
        publickeys = Array.new
        shu.sshuser_mbrs.each do |member|
          if member.sshkey_id
            publickeys << member.sshkey.key_public_auth
          else
            publickeys = publickeys + member.sshkey_group.getKeysFromMembers
          end
        end
        mykeys[shu.username] = mykeys[shu.username] + publickeys
      end

      mykeys.each do |key, value|
        user_xml = server_xml.add_element "username", {"name" => key}
        value.each do |kvalue|
          key = user_xml.add_element "key"
          key.add_text kvalue
        end
      end
    end

    respond_to do |format|
      format.xml { render :xml => xml }
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
