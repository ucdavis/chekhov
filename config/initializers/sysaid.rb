SYSAID_SETTINGS_FILE = Rails.root.join( "config", "sysaid.yml")

if File.file?(SYSAID_SETTINGS_FILE)
  SYSAID_SETTINGS = YAML.load_file(SYSAID_SETTINGS_FILE)
else
  puts "You need to set up config/sysaid.yml before running this application."
  exit
end
