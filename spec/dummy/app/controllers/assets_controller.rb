class AssetsController < ApplicationController
  def create
    asset = Asset.new(file: params[:file])
    asset.save

    render json: asset
  end
end
