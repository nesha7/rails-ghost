class ScriptsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @header_script = Script.find_or_initialize_by(key: 'header')
    @footer_script = Script.find_or_initialize_by(key: 'footer')
  end

  def update
    script = Script.find_or_initialize_by(key: params[:key])
    if script.update(value: params[:value])
      redirect_to scripts_path, notice: "#{params[:key].capitalize} script updated!"
    else
      redirect_to scripts_path, alert: "Failed to update script"
    end
  end

  private

  def ensure_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user.admin?
  end
end
