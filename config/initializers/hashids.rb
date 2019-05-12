Hashid::Rails.configure do |config|
    # The salt to use for generating hashid. Prepended with table name.
    config.salt = %(_6^'8<yA=st?"Lx7)
    
    # The minimum length of generated hashids
    config.min_hash_length = 6
    
    
    # Whether to override the `find` method
    config.override_find = true
    
    # Whether to sign hashids to prevent conflicts with regular IDs (see https://github.com/jcypret/hashid-rails/issues/30)
    config.sign_hashids = true
end
