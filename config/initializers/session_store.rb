# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_xendamailer_session',
  :secret => '454992c4db9c80b94e3740a7d006c109d47da329b3efbcdec6ccbb81044f857d30f88a491b66a8c41c31161f527495ee0297a66dc746c1c60b2f156d94d1cf2e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
