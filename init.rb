require 'redmine'
require 'mailer_patch'
require_dependency 'emails/hooks'

Redmine::Plugin.register :redmine_emails do
  name 'Emails plugin'
  author 'Alex'
  description 'Plugin for notification of external addresses'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
