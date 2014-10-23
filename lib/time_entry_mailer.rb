# Timelog Mailer Plugin
# (C) 2014 vjt@openssl.it
# MIT License
#
class TimeEntryMailer < ActionMailer::Base

  layout 'mailer'

  helper :application
  helper :issues
  helper :custom_fields

  def self.default_url_options
    { :host => Setting.host_name, :protocol => Setting.protocol }
  end

  def time_logged(time_entry)
    @entry   = time_entry
    @issue   = time_entry.issue
    @actor   = time_entry.user
    @project = time_entry.project
    @hours   = time_entry.hours

    to = @issue.notified_users.map(&:mail) - [ @actor.mail ]
    cc = @issue.notified_watchers.map(&:mail) - to

    mail from: Setting.mail_from, to: to, cc: cc, subject: "#@hours hours logged by #@actor on #@project"
  end
end
