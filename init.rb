# Timelog Mailer Plugin
# (C) 2014 vjt@openssl.it
# MIT License
#
require 'redmine'

Redmine::Plugin.register :timelog_mailer do
  name 'Time Log Mailer'
  author 'Marcello Barnaba'
  description 'E-mails issue recipients when time entries are logged'
  version '0.0.1'
  url 'https://github.com/vjt/redmine-timelog-mailer'
  author_url 'http://sindro.me'

  requires_redmine :version_or_higher => '2.4.0'
end

ActionDispatch::Callbacks.to_prepare do

  TimeEntryObserver.instance # Instantiate and register the observer

end
