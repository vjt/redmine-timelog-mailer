# Timelog Mailer Plugin
# (C) 2014 vjt@openssl.it
# MIT License
#
class TimeEntryObserver < ActiveRecord::Observer
  observe :time_entry

  def after_create(time_entry)
    if time_entry.project.enabled_modules.where(name: 'time_tracking_mailer').exists?
      TimeEntryMailer.time_logged(time_entry).deliver!
    end
  end
end
