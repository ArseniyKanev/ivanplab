class FilesController < ApplicationController
    before_action :set_current_directory
    before_action :check_user_signed_in
    before_action :is_admin?, only: [:delete_file, :delete_folder]

    def index
      @directories = Dir.entries(@current_directory).select { |f| File.directory?(File.join(@current_directory, f)) && !['.', '..'].include?(f) }
      @files = Dir.entries(@current_directory).select { |f| File.file?(File.join(@current_directory, f)) }
    end

    def create_folder
      folder_name = params[:folder_name]
      new_folder_path = File.join(@current_directory, folder_name)

      if !File.exist?(new_folder_path)
        Dir.mkdir(new_folder_path)
        redirect_back(fallback_location: root_path, notice: "Folder '#{folder_name}' created successfully.")
      else
        redirect_back(fallback_location: root_path, alert: "Folder '#{folder_name}' already exists.")
      end
    end

    def upload_file
      uploaded_file = params[:file]
      if uploaded_file.present?
        file_path = File.join(@current_directory, uploaded_file.original_filename)
        File.open(file_path, 'wb') do |file|
          file.write(uploaded_file.read)
        end
        redirect_back(fallback_location: root_path, notice: "File '#{uploaded_file.original_filename}' uploaded successfully.")
      else
        redirect_back(fallback_location: root_path, alert: "No file selected.")
      end
    end

    def delete_file
      file_path = File.join(@current_directory, params[:path])
        if File.exist?(file_path)
          File.delete(file_path)
          flash[:notice] = "File deleted successfully."
        else
          flash[:alert] = "File not found."
        end

        redirect_back(fallback_location: root_path)
    end

    def delete_folder
      if Dir.exist?(@current_directory)
        FileUtils.rm_rf(@current_directory)
        flash[:notice] = "Folder and its contents deleted successfully."
      else
        flash[:alert] = "Folder not found."
      end

      redirect_back(fallback_location: root_path)
    end

    def is_admin?
      redirect_back(fallback_location: root_path, alert: "Admins only") unless current_user.admin?
    end

    private

    def check_user_signed_in
      if !user_signed_in?
        flash[:notice] = I18n.t 'only_registered'
        redirect_to :root
      end
    end

    def set_current_directory
      base_directory = Rails.root.join('public', 'uploads', 'sharing')
      @current_directory = params[:dir] ? File.join(base_directory, params[:dir]) : base_directory
    end
  end
