# Timelog Mailer Plugin
# (C) 2014 vjt@openssl.it
# MIT License
#
require 'redmine'

Redmine::Plugin.register :timelog_mailer do
  name 'Time Log Mailer'
  author 'Marcello Barnaba'
  description 'E-mails project members when time entries are logged'
  version '0.1.2'
  url 'https://github.com/vjt/redmine-timelog-mailer'
  author_url 'http://sindro.me'

  requires_redmine :version_or_higher => '2.4.0'
end

ActionDispatch::Callbacks.to_prepare do

  # Instantiate and register the TimeEntry observer
  #
  TimelogMailer::TimeEntryObserver.instance

  # Add our views to ActionMailer
  #
  ActionMailer::Base.append_view_path Pathname.new(__FILE__).dirname.join('app/views')

  # Add this module to the list of available project modules
  #
  Redmine::AccessControl.map do |map|
    map.project_module :time_tracking_mailer do |map|
      map.permission :log_time, { timelog: [:new, :create] }, require: :loggedin
    end
  end

end
