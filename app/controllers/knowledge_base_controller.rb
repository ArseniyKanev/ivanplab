class KnowledgeBaseController < FilesController
    before_action :up_current_directory
    skip_before_action :check_user_signed_in

    private

    def up_current_directory
        @base_directory = Rails.root.join(@base_directory, 'knowledge_base')
        @current_directory = params[:dir] ? File.join(@base_directory, params[:dir]) : @base_directory
    end
end
