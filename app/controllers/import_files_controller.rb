class ImportFilesController < ApplicationController
  def index
    @import_file = ImportFile.new
    @import_files = ImportFile.order(created_at: :desc)
  end

  def create
    @import_file = ImportFile.new(import_file_params)
    if @import_file.save
      redirect_to root_path, flash: {success: 'Import is processing'}
    else
      redirect_to root_path, flash: {error: 'Import failed'}
    end
  end

  protected
    def import_file_params
      params.require(:import_file).permit(:file)
    end
end
