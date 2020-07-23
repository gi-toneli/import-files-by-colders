class ImportFilesController < ApplicationController
  def index
    @import_file = ImportFile.new
  end

  def show
  end

  def create

  end

  protected
    def import_file_params
      params.require(:import_file).permit(:file)
    end
end
