require 'zip'
require 'fileutils'
class Download
 def initialize(file_paths)
   @file_paths = file_paths
   @zipfiles_folder = File.join(Rails.root,"TAFF_ZIP")
   delete_directory if directory_present?
   create_directory if directory_present?
 end

 def directory_present?
   taff_zip_dir = File.dirname(@zipfiles_folder)
   File.directory?(taff_zip_dir)
 end

 def create_directory
   FileUtils.mkdir_p(@zipfiles_folder)
 end

 def download_file
   file_path = @file_paths.first
   send_file(File.open(file_path))
 end

 def download_with_zip
   zipfile_name = File.join(@zipfiles_folder,"script.zip")
   Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
     @file_paths.each do |filepath|
       folder = File.dirname(filepath)
       filename = File.basename(filepath)
       zipfile.add(filename, folder + '/' + filename)
     end
   end
   zipfile_name
 end

 def delete_directory
   FileUtils.rm_rf(@zipfiles_folder)
 end

end