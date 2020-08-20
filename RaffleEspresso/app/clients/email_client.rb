  require 'mail'
  require 'redis'
  require 'net/smtp'
  require 'simple_mail_builder'
  require 'openssl'
  
  class EmailClient
    def initialize(to_address, from_address, email_pass, subject, body, email_domain)

        begin
            OpenSSL::SSL::SSLContext::DEFAULT_PARAMS
            options = {
                :address              => "smtp.gmail.com",
                :port                 => "25",
                :user_name            => from_address,
                :password             => email_pass,
                :authentication       => :login,
                :openssl_verify_mode  => 'none'
            }

            Mail.defaults do
                delivery_method :smtp, options
            end

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
