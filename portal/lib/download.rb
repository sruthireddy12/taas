require 'zip'
require 'fileutils'
require 'pathname'
class Download
 def initialize(file_paths)
   @file_paths = file_paths
   @zipfiles_folder = File.join(Rails.root,"TAFF_ZIP")
   @current_zip_folder = File.join(@zipfiles_folder, Date.today.strftime('%j'))
   delete_old_directories if directory_present?
   create_directory unless current_directory_present?
 end

 def delete_old_directories
   all_directories = Pathname.new(@zipfiles_folder).children.select { |c| c.directory? }.collect { |p| p.to_s }
   unless all_directories.blank?
     all_directories.delete(@current_zip_folder)
     all_directories.each do |dir_path|
       delete_directory(dir_path)
     end
   end
 end

 def current_directory_present?
   File.directory?(@current_zip_folder)
 end

 def directory_present?
   taff_zip_dir = File.dirname(@zipfiles_folder)
   File.directory?(taff_zip_dir)
 end

 def create_directory
   FileUtils.mkdir_p(@current_zip_folder)
 end

 def download_file
   file_path = @file_paths.first
   send_file(File.open(file_path))
 end

 def download_with_zip
   script_name = "script" + Time.now.strftime("%T").delete(':') + ".zip"
   zipfile_name = File.join(@current_zip_folder,script_name)
   Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
     @file_paths.each do |filepath|
       folder = File.dirname(filepath)
       filename = File.basename(filepath)
       zipfile.add(filename, folder + '/' + filename)
     end
   end
   zipfile_name
 end

 def delete_directory(dir_path)
   FileUtils.rm_rf(dir_path)
 end

end