class Ckeditor::Picture < Ckeditor::Asset
  mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name
  def self.inheritance_column
    nil
  end
  def url_content
    url(:content)
  end
end
