class AssetsController < ApplicationController
  respond_to :json

  def create
    @asset = Asset.new(file: params[:file])
    @asset.save
    respond_with @asset
  end
end
