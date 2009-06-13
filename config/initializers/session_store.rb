# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_barf_session',
  :secret      => '4174e8bad59f3c0434c76e5596c40bdf1da51eae8f51f07bbda4af030d2239439deac12697d51d295b5c94898fdddf163f20c698cb1f867eb159650c0ff1be21'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
