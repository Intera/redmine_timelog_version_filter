module RedmineTimelogVersionFilter

  # Patches Redmine's TimeEntryPatch dynamically. Adds the method issue_fixed_version().
  module TimeEntryPatch

    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods

      def issue_fixed_version
          issue.fixed_version unless issue.nil?
      end

    end

  end
end

TimeEntry.send(:include, RedmineTimelogVersionFilter::TimeEntryPatch)