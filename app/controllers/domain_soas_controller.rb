class DomainSoasController < ApplicationController
  def edit
    @domain = Domain.find(params[:domain_id])
  end
end