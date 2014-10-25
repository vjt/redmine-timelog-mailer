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
    @activity = time_entry.activity
    @hours   = time_entry.hours
    @rcpts   = @project.members.map {|m| m.user.mail } - [ @actor.mail ]

    @issue ? issue_time_logged : project_time_logged
  end

  private
    def issue_time_logged
      subject = "[#{@project.name} - #{@issue.tracker.name} ##{@issue.id}] #@hours hours logged by #@actor"
      mail subject, 'issue_time_logged'
    end

    def project_time_logged
      subject = "[#{@project.name}] #@hours hours logged by #@actor"
      mail subject, 'project_time_logged'
    end

    def mail(subject, template)
      super from: Setting.mail_from, to: @rcpts, subject: subject do |format|
        format.text { render "time_entry_mailer/#{template}" }
      end
    end
end
