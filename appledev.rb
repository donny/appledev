require 'nokogiri'
require 'open-uri'
require 'net/https'

APPLE_STATUS_URL = 'https://developer.apple.com/support/system-status/'

services = {'Certificates, Identifiers & Profiles' => ['service-down', 'Certs, Ids & Profiles'],
            'Xcode Automatic Configuration' => ['service-down', 'Xcode Automatic Config'],
            'Pre-Release Documentation' => ['service-down', 'Pre-Release Doc'],
            'Software Downloads' => ['service-down', 'Software Downloads'],
            'Videos' => ['service-down', 'Videos'],
            'Member Center' => ['service-down', 'Member Center'],
            'iOS Dev Center' => ['service-down', 'iOS Dev Center'],
            'Mac Dev Center' => ['service-down', 'Mac Dev Center'],
            'Safari Dev Center' => ['service-down', 'Safari Dev Center'],
            'App Store Resource Center' => ['service-down', 'App Store Resource'],
            'iTunes Connect' => ['service-down', 'iTunes Connect'],
            'Program Enrollment and Renewals' => ['service-down', 'Program Enrollment'],
            'Apple Developer Forums' => ['service-down', 'Apple Developer Forum'],
            'Bug Reporter' => ['service-down', 'Bug Reporter'],
            'Technical Support' => ['service-down', 'Technical Support']}

SCHEDULER.every '10m' do
  doc = Nokogiri::HTML(open(APPLE_STATUS_URL, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
  # We search for the <a> HTML tag, if it is found, the service is up.
  xpath = '//*[@id="content"]/div[2]/div/section/div/table/tr/td/span/a/text()'
  xpath_results = doc.xpath(xpath)

  xpath_results.each do |service|
    services[service.content][0] = 'service-up'
  end 

  values = {}

  services.each do |key,value|
    values[key] = { label: value[1], class: value[0] }
  end
  
  send_event('appledev', { items: values.values })
end
