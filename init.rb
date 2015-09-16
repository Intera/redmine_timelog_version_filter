require 'redmine'
require 'redmine_timelog_version_filter/time_entry_patch'
require 'redmine_timelog_version_filter/time_entry_query_patch'

Redmine::Plugin.register :redmine_timelog_version_filter do
  name 'Redmine timelog version filter'
  author 'Intera GmbH'
  description 'This plugin allows filtering for issue versions in the timelog.'
  version '0.0.1'
  url 'https://github.com/Intera/redmine_timelog_version_filter'
end
