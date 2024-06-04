class UploadController < ActionController::Base
  IMAGE_EXT = [".gif", ".jpeg", ".jpg", ".png", ".svg"]

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
    raise "Not allowed" unless IMAGE_EXT.include?(ext)
  end

  def access_file
    if File.exist?(Rails.root.join("public", "uploads", "files", params[:name]))
      DownloadAction.new(filename: params[:name], user_id: current_user.id).save!
      send_data File.read(Rails.root.join("public", "uploads", "files", params[:name])), disposition: "attachment"
    else
      render nothing: true
    end
  end
end
