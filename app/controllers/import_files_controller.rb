class ImportFilesController < ApplicationController
  def index
    @import_file = ImportFile.new
    @import_files = ImportFile.order(created_at: :desc)
  end

  def create
    @import_file = ImportFile.new(import_file_params)
    if @import_file.save
      redirect_to root_path, flash: {success: 'Importação realizada com sucesso'}
    else
      redirect_to root_path, flash: {error: 'Falha na importação reveja seu arquivo'}
    end
  end

  protected
    def import_file_params
      params.require(:import_file).permit(:file)
    end
end
