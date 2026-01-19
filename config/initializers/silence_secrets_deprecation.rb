# Silence the Rails.application.secrets deprecation warning
# This app uses Rails credentials (credentials.yml.enc), not the deprecated secrets.yml
# Rails internally checks for secrets during initialization, causing this warning
# Remove this file when upgrading to Rails 7.2+

if Rails.env.test? || Rails.env.development?
  ActiveSupport::Deprecation.behavior = lambda do |message, callstack, deprecation_horizon, gem_name|
    # Only silence the specific secrets deprecation warning
    unless message.include?("Rails.application.secrets is deprecated")
      # Print other deprecation warnings to stderr as normal
      warn message
    end
  end
end
