class FilesController < ApplicationController
    before_action :set_current_directory
    before_action :check_user_signed_in
    before_action :is_admin?, only: [:create_folder, :create_folder, :delete_file, :delete_folder]

    def index
      @directories = Dir.entries(@current_directory)
        .select { |f| File.directory?(File.join(@current_directory, f)) && !['.', '..'].include?(f) }
        .map { |f| [File.join(@current_directory, f), File.ctime(File.join(@current_directory, f))] }
        .sort_by { |_, ctime| ctime }
        .reverse
        .map { |f, _| File.basename(f) }
      @files = Dir.entries(@current_directory)
        .select { |f| File.file?(File.join(@current_directory, f)) }
        .map { |f| [File.join(@current_directory, f), File.ctime(File.join(@current_directory, f))] }
        .sort_by { |_, ctime| ctime }
        .reverse
        .map { |f, _| File.basename(f) }
    end

    def create_folder
      folder_name = params[:folder_name]
      new_folder_path = File.join(@current_directory, folder_name)

      if !File.exist?(new_folder_path)
        Dir.mkdir(new_folder_path)
        redirect_back(fallback_location: root_path, notice: I18n.t('toasts.folder_created', folder_name: folder_name))
      else
        redirect_back(fallback_location: root_path, alert: I18n.t('toasts.folder_exists', folder_name: folder_name))
      end
    end

    def upload_file
      uploaded_file = params[:file]
      if uploaded_file.present?
        file_path = File.join(@current_directory, uploaded_file.original_filename)
        File.open(file_path, 'wb') do |file|
          file.write(uploaded_file.read)
        end
        redirect_back(fallback_location: root_path, notice: I18n.t('toasts.file_uploaded', file_name: uploaded_file.original_filename))
      else
        redirect_back(fallback_location: root_path, alert: I18n.t('toasts.no_file_selected'))
      end
    end

    def delete_file
      file_path = File.join(@current_directory, params[:path])
        if File.exist?(file_path)
          File.delete(file_path)
          flash[:notice] = I18n.t('toasts.file_deleted')
        else
          flash[:alert] = I18n.t('toasts.file_not_found')
        end

        redirect_back(fallback_location: root_path)
    end

    def delete_folder
      if Dir.exist?(@current_directory)
        FileUtils.rm_rf(@current_directory)
        flash[:notice] = I18n.t('toasts.folder_deleted')
      else
        flash[:alert] = I18n.t('toasts.folder_not_found')
      end

      redirect_back(fallback_location: root_path)
    end

    def is_admin?
      redirect_back(fallback_location: root_path, alert: I18n.t('toasts.admins_only')) unless current_user.admin?
    end

    private

    def check_user_signed_in
      if request.path.start_with?('/knowledge_base')
        return
      end

      if !user_signed_in?
        flash[:notice] = I18n.t 'only_registered'
        redirect_to :root
      end
    end

    def set_current_directory
      @base_directory = Rails.root.join('public', 'uploads')
      @current_directory = params[:dir] ? File.join(@base_directory, params[:dir]) : @base_directory
    end
  end
