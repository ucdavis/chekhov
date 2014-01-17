SYSAID_SETTINGS_FILE = Rails.root.join( "config", "sysaid.yml")

if File.file?(SYSAID_SETTINGS_FILE)
  SYSAID_SETTINGS = YAML.load_file(SYSAID_SETTINGS_FILE)
  
  SysAid::login SYSAID_SETTINGS["ACCOUNT"], SYSAID_SETTINGS["USER"], SYSAID_SETTINGS["PASSWORD"], SYSAID_SETTINGS["WSDL_URI"]
else
  puts "You need to set up config/sysaid.yml before running this application."
  exit
end
