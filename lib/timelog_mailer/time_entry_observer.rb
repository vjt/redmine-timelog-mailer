# Timelog Mailer Plugin
# (C) 2014 vjt@openssl.it
# MIT License
#
module TimelogMailer
  class TimeEntryObserver < ActiveRecord::Observer
    observe :time_entry

    def after_create(time_entry)
      if should_email?(time_entry)
        TimeEntryMailer.deliver_time_logged_in(time_entry)
      end
    end

    private
      def should_email?(time_entry)
        mailer_enabled?(time_entry.project)
      end

      def mailer_enabled?(project)
        project.enabled_modules.where(name: 'time_tracking_mailer').exists?
      end
  end
end
