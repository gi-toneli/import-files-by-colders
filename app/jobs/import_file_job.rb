class ImportFileJob < ApplicationJob
  queue_as :import_file_lines

  def perform(import_file_id)
    import_file = ImportFile.find(import_file_id)
    lines = []
    File.readlines(import_file.file_name).each do |line|
      lines << line[0..80]
    end
    import_file.update_attribute(:count_lines, lines.count)
    lines.each do |line|
      import_file_line = import_file.import_file_lines.build(line: line)
      import_file_line.save
    end
    # import_file.finished!
  end
end
