# README
## Run the app:
``
bundle exec rails server
``
## Phrasing

### Sign in
go to /users/sign_in

### Sign out
go to /users/sign_out

### Remove unused keys
``
used_keys = Dir.glob("app/views/**/*.{erb,haml,slim}").flat_map do |file|
  content = File.read(file)
  
  **Capture all phrase() or safe_phrase() calls**

  content.scan(/(?:safe_)?phrase\(['"]([^'"]+)['"]/).flatten
end.uniq

**Only keep keys starting with 'litetracker_'**

used_keys.select! { |k| k.start_with?("litetracker_") }

db_keys = PhrasingPhrase.where("key LIKE ?", "litetracker_%").pluck(:key)

unused_keys = db_keys - used_keys

PhrasingPhrase.where(key: unused_keys).destroy_all
``
