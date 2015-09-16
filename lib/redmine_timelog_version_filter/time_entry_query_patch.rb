module RedmineDefaultPrivateComments

  # Patches Redmine's TimeEntryQuery dynamically. Adds field / filter for the issue version.
  module TimeEntryQuery

    def self.included(base) # :nodoc:
      base.available_columns << QueryColumn.new(:issue_fixed_version, :sortable => "#{Issue.table_name}.fixed_version_id");
      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
        alias_method_chain :initialize_available_filters, :versionfilter
      end
    end

    module InstanceMethods

      def initialize_available_filters_with_versionfilter
        initialize_available_filters_without_versionfilter
        if project
          versions = project.shared_versions.to_a
          if versions.any?
            add_available_filter "issue_fixed_version_id",
                                 :type => :list_optional,
                                 :values => versions.sort.collect{|s| ["#{s.project.name} - #{s.name}", s.id.to_s] }
          end
        end
      end

      def sql_for_issue_fixed_version_id_field(field, operator, value)
        sql_for_field(field, operator, value, "issues", "fixed_version_id")
      end

    end

  end
end

TimeEntryQuery.send(:include, RedmineDefaultPrivateComments::TimeEntryQuery)