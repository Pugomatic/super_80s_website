class SitesController < ApplicationController
   before_action :find_site

  layout :resolve_layout

  def index
  end

  private

  def find_site
    @site = Site.where(domain: request.host).first
  end

  def resolve_layout
    @site.layout || 'application'
  end
end