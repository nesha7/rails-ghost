class Admin::PageMetadataController < Admin::BaseController
  before_action :authenticate_user!
  before_action :ensure_admin!
  before_action :set_page_metadata, only: %i[edit update destroy]

  layout 'admin'

  def index
    @page_metadata = PageMetadata.order(:slug)
  end

  def new
    @page_metadata = PageMetadata.new
  end

  def create
    @page_metadata = PageMetadata.new(page_metadata_params)
    if @page_metadata.save
      redirect_to admin_page_metadata_path, notice: "Page metadata created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @page_metadata.update(page_metadata_params)
      redirect_to admin_page_metadata_path, notice: "Page metadata updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @page_metadata.destroy
    redirect_to admin_page_metadata_path, notice: "Page metadata deleted."
  end

  private

  def set_page_metadata
    @page_metadata = PageMetadata.find(params[:id])
  end

  def page_metadata_params
    params.require(:page_metadata).permit(:slug, :meta_title)
  end
end
