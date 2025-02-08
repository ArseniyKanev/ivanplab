class UploadController < ActionController::Base
  IMAGE_EXT = [".gif", ".jpeg", ".jpg", ".png", ".svg"]

  before_action :set_current_directory, only: [:access_file]

  def upload_file
    if params[:file]
      FileUtils::mkdir_p(Rails.root.join("public/uploads/files"))

      file_name = params[:file].original_filename
      path = Rails.root.join("public/uploads/files/", params[:file].original_filename)

      File.open(path, "wb") {|f| f.write(params[:file].read)}
      view_file = Rails.root.join("/download_file/", file_name).to_s
      render json: {link: view_file}.to_json
    else
      render text: {link: nil}.to_json
    end
  end

  def upload_image
    if params[:file]
      FileUtils::mkdir_p(Rails.root.join("public/uploads/files"))

      ext = File.extname(params[:file].original_filename)
      ext = image_validation(ext)
      file_name = "#{SecureRandom.urlsafe_base64}#{ext}"
      path = Rails.root.join("public/uploads/files/", file_name)

      File.open(path, "wb") {|f| f.write(params[:file].read)}
      view_file = Rails.root.join("/download_file/", file_name).to_s
      render json: {link: view_file}.to_json

    else
      render text: {link: nil}.to_json
    end
  end

  def image_validation(ext)
    raise "Not allowed" unless IMAGE_EXT.include?(ext.downcase)
  end

  def access_file
    if File.exist?(Rails.root.join("public", "uploads", "files", params[:name]))
      ext = File.extname(params[:name])
      DownloadAction.new(filename: params[:name], user_id: current_user.id).save! unless (IMAGE_EXT.include?(ext) || ext == "")
      send_data File.read(Rails.root.join("public", "uploads", "files", params[:name])), disposition: "attachment"
    elsif File.exist?(File.join(@current_directory, params[:name]))
      ext = File.extname(params[:name])
      DownloadAction.new(filename: params[:name], user_id: current_user.id).save! unless (IMAGE_EXT.include?(ext) || ext == "")
      send_data File.read(File.join(@current_directory, params[:name])), disposition: "attachment"
    else
      render nothing: true
    end
  end

  private

  def set_current_directory
    base_directory = Rails.root.join('public', 'uploads', 'sharing')
    @current_directory = params[:dir] ? File.join(base_directory, params[:dir]) : base_directory
  end
end
