require 'puppet'
require 'yaml'

begin
  require 'ruby-nabaztag'
rescue LoadError => e
  Puppet.info "You need the `ruby-nabaztag` gem to use the Nabaztag report"
end

Puppet::Reports.register_report(:nabaztag) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "nabaztag.yaml"])
  raise(Puppet::ParseError, "Nabaztag report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  NABAZTAG_SERIAL = config[:nabaztag_serial]
  NABAZTAG_TOKEN  = config[:nabaztag_token]

  desc <<-DESC
  Send notification of failed reports to Nabaztag.
  DESC

  def process
    if self.status == 'failed'
      Puppet.debug "Sending status for #{self.host} to Nabaztag."
      nabaztag = Nabaztag.new(#{NABAZTAG_SERIAL}, #{NABAZTAG_TOKEN})
      msg = "Puppet run for #{self.host} #{self.status}"
      nabaztag.say(msg)
      nabaztag.send
    end
  end
end
