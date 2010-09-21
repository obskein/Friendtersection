# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fb3_session',
  :secret      => 'f73ce201bfa24c1913c16303eef57d94d7e815b8f8d07955bd28df8a4b1cefa6e58f64be9f29675e4c55e9be29c485303970638f6bf853de37d7e27ac4c576d5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
