  require 'mail'
  require 'redis'
  require 'net/smtp'
  require 'simple_mail_builder'
  require 'openssl'
  require ''
  
  class EmailClient
    def initialize(to_address, from_address, email_pass, subject, body)

        begin
            OpenSSL::SSL::SSLContext::DEFAULT_PARAMS
            options = {
                :address              => "smtp.gmail.com",
                :port                 => "25",
                # proxy_address: proxy_address,
                # proxy_port: proxy_port,
                :user_name            => from_address,
                :password             => email_pass,
                :authentication       => :login,
                :openssl_verify_mode  => 'none'
            }

            Mail.defaults do
                delivery_method Net::SMTP::Proxy::DeliveryMethod, options
            end

            # delivery_method Net::SMTP::Proxy::DeliveryMethod, {
            #   address: address,
            #   port: port,
            #   proxy_address: proxy_address,
            #   proxy_port: proxy_port,
            #   domain: 'mydomain.com'
            # }

            Mail.deliver do
                to to_address
                from from_address
                subject subject
                body body
            end

            puts("\nSent message. From: #{from_address} To: #{to_address} \nMessage body: \n#{body}")

            return true

        rescue Exception => e
            puts e.to_s
            return false
        end
    end
end
