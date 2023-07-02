require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CatStroll
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # 通報機能ステータスの日本語化
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/*.yml').to_s]
    
    # public新規登録画面エラー時のレイアウト調節
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        method_name = instance.instance_variable_get(:@method_name)
        errors = instance.object.errors[method_name]
        errors_tag = errors.map do |error|
          %(<span class="error-msg">#{error}</span>)
        end
    
        html = <<~EOM
        <div class="field_with_errors">
          #{html_tag}<br>
          #{errors_tag.join}
        </div>
        EOM
        html.html_safe
      end
    end

  end
end
