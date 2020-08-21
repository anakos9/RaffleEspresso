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
      when "outlook"
        domain_address = "smtp.office365.com"
      end

      composed_body = "#{item_name}\n#{size}\n\n#{first_name.capitalize} #{last_name.capitalize}\n#{street_and_number}\n#{city}\n#{zip_code}\n#{phone_number}"

      begin
          OpenSSL::SSL::SSLContext::DEFAULT_PARAMS
          if email_domain == "gmail"
            options = {
                :address              => domain_address,
                :port                 => "25",
                :user_name            => from_address,
                :password             => email_pass,
                :authentication       => :login,
                :openssl_verify_mode  => 'none'
            }
          else
            options = {
              :address              => domain_address,
              :port                 => "25",
              :user_name            => from_address,
              :password             => email_pass,
              :authentication       => :plain,
              :enable_starttls_auto => true
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

          puts "Sent message. \nFrom: #{from_address} To: #{to_address} \nMessage body: \n#{composed_body}" if File.write("successful_entries.txt", "#{from_address}.", mode: "a")
          return true

      rescue Exception => e
          puts e.to_s
          return false
      end
  end

end
