# frozen_string_literal: true

loader = RedminePluginKit::Loader.new plugin_id: 'redmine_messenger'

Redmine::Plugin.register :redmine_messenger do
  name 'Redmine Messenger'
  author 'AlphaNodes GmbH'
  url 'https://github.com/alphanodes/redmine_messenger'
  author_url 'https://alphanodes.com/'
  description 'Messenger integration for Slack, Discord, Rocketchat and Mattermost support'
  version RedmineMessenger::VERSION

  requires_redmine version_or_higher: '4.1.0'

  permission :manage_messenger, projects: :settings, messenger_settings: :update

  settings default: {
    messenger_url: '',
    messenger_icon: 'https://raw.githubusercontent.com/alphanodes/redmine_messenger/master/assets/images/icon.png',
    messenger_channel: 'redmine',
    messenger_username: 'robot',
    messenger_verify_ssl: '1',
    messenger_direct_users_messages: '0',
    auto_mentions: '0',
    default_mentions: '',
    display_watchers: '0',
    post_updates: '1',
    new_include_description: '1',
    updated_include_description: '1',
    post_private_contacts: '0',
    post_private_db: '0',
    post_private_issues: '0',
    post_private_notes: '0',
    post_wiki: '0',
    post_wiki_updates: '0',
    post_db: '0',
    post_db_updates: '0',
    post_contact: '0',
    post_contact_updates: '0',
    post_password: '0',
    post_password_updates: '0'
  }, partial: 'settings/messenger_settings'
end

RedminePluginKit::Loader.persisting { loader.load_model_hooks! }
RedminePluginKit::Loader.to_prepare { RedmineMessenger.setup! } if Rails.version < '6.0'
