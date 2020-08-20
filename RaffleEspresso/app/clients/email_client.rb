  require 'mail'
  require 'redis'
  require 'net/smtp'
  require 'simple_mail_builder'
  require 'openssl'
  
  class EmailClient
    def initialize(to_address, from_address, email_pass, mail_content)
        
        item_name = mail_content[:item_name]
        subject = mail_content[:subject]
        first_name = mail_content[:first_name]
        last_name = mail_content[:last_name]
        street_and_number = mail_content[:street_and_number]
        zip_code = mail_content[:zip_code]
        city = mail_content[:city]
        size = mail_content[:size]
        phone_number = mail_content[:phone_number]
        email_domain = mail_content[:from_domain]

        case email_domain
        when "gmail"
          domain_address = "smtp.gmail.com"
          port = "25"
        when "outlook"
          domain_address = "smtp.office365.com"
          port = "587"
        end

        composed_body = "
        #{item_name}
        #{size}\n
        #{first_name.capitalize} #{last_name.capitalize}
        #{street_and_number}
        #{city}
        #{zip_code}
        #{phone_number}
        "

        puts "Composed:", composed_body

        begin
            OpenSSL::SSL::SSLContext::DEFAULT_PARAMS
            if email_domain == "email"
              options = {
                  :address              => domain_address,
                  :port                 => port,
                  :user_name            => from_address,
                  :password             => email_pass,
                  :authentication       => :login,
                  :openssl_verify_mode  => 'none'
              }
            else
              options = {
                :address              => domain_address,
                :port                 => port,
                :user_name            => from_address,
                :password             => email_pass,
                :openssl_verify_mode  => 'none'
              }
            end

            Mail.defaults do
                delivery_method :smtp, options
            end

            Mail.deliver do
                to to_address
                from from_address
                subject subject
                body composed_body
            end

            puts "\nSent message. From: #{from_address} To: #{to_address} \nMessage body: \n#{composed_body}"
            
            return true

        rescue Exception => e
            # puts e.to_s
            return false
        end
    end
end
