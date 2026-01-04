class DownloadsController < FilesController
    before_action :up_current_directory

    private

    def up_current_directory
        @base_directory = Rails.root.join(@base_directory, 'sharing')
        @current_directory = params[:dir] ? File.join(@base_directory, params[:dir]) : @base_directory
    end
end
