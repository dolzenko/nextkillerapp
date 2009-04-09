# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nextkillerapp_session',
  :secret      => 'cf2be8de9bbaf030a47564f14efc2f4a12f79efb7bfa9d4a205a04c0612cd95b5089f0904d427a98dd0c3ebfad17268b1e351dfc447cb7aca0e61dd6d647f6ab'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
