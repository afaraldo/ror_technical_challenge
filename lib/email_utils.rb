# encoding: UTF-8

require 'net/http'
require 'uri'
require 'json'
require 'logger'

class EmailUtils
  SENDGRID_API_URI = URI.parse('https://api.sendgrid.com/v3/mail/send')

  def self.send(to, substitutions, template_id, cc=nil)
    Rails.logger.debug "Call EmailUtils.send to: #{to}, substitutions: #{substitutions}, template_id: #{substitutions}, cc: #{cc}"
    http = Net::HTTP.new(SENDGRID_API_URI.host, SENDGRID_API_URI.port)
    http.use_ssl = true
    from = ENV["SENDGRID_SENDER"]

    request = Net::HTTP::Post.new(SENDGRID_API_URI.request_uri)
    request['Authorization'] = "Bearer #{ENV['SENDGRID_API_KEY']}"
    request['Content-Type'] = 'application/json'

    personalization = {
      to: to,
      subject: substitutions["subject"],
      dynamic_template_data: substitutions
    }
    personalization[:cc] = cc if cc && cc.any?

    request.body = {
      "personalizations" => [personalization],
      "from" => { email: from },
      "template_id" => template_id
    }.to_json

    begin
      response = http.request(request)




      unless response.is_a?(Net::HTTPAccepted)
        Rails.logger.error("Error al enviar el correo: #{response.code} #{response.message}")
        return false
      end

      response
    rescue Timeout::Error => e
      Rails.logger.error("Error de conexión al enviar correo: #{e.message}")
      return e
    rescue JSON::ParserError => e
      Rails.logger.error("Error al procesar la respuesta: #{e.message}")
      return e
    rescue => e
      Rails.logger.error("Error inesperado: #{e.message}")
      return e
    end
  end
end
