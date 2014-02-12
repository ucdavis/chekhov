# This exception error is provided for your use.
class SysAidError < StandardError
end

SYSAID_SETTINGS_FILE = Rails.root.join( "config", "sysaid.yml")

if File.file?(SYSAID_SETTINGS_FILE)
  SYSAID_SETTINGS = YAML.load_file(SYSAID_SETTINGS_FILE)
  SysAid::server_settings = { account: SYSAID_SETTINGS["ACCOUNT"], username: SYSAID_SETTINGS["USER"], password: SYSAID_SETTINGS["PASSWORD"], wsdl_uri: SYSAID_SETTINGS["WSDL_URI"] }
else
  puts "You need to set up config/sysaid.yml before running this application."
  exit
end
