class SessionCleaner
  def self.remove_stale_sessions
    # clean stale sessions
    ActiveRecord::SessionStore::Session.delete_all( ['updated_at < ?', MAX_SESSION_PERIOD.ago] )
    # clean loooong lasting session - CSRF protection
    ActiveRecord::SessionStore::Session.delete_all( ['created_at < ?', MAX_SESSION_LIMIT.ago] )
  end
end
