class ImportFilesController < ApplicationController
  def index
    @import_file = ImportFile.new
  end

  def show
  end
end
