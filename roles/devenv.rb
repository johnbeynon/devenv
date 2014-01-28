name "devenv"
description "Development Environment"

#default_attributes(
#  "chruby" => {
#    "rubies" => {
#      "1.9.3-p392" => false,
#      "1.9.3-p429" => true
#    },
#    "default" => "1.9.3-p429"
#  }
#)
#
set['postgresql']['config']['ssl_key_file']  = "/etc/ssl/private/ssl-cert-snakeoil.key"
set['postgresql']['config']['ssl_cert_file'] = "/etc/ssl/certs/ssl-cert-snakeoil.pem"

