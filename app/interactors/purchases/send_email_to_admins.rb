class Purchases::SendEmailToAdmins
  include Interactor

  def call
    Rails.logger.debug "===---> Entering Call Purchases::SendEmailToAdmins [Interactor]"
    Rails.logger.debug { "context.user #{context.user.inspect}" }
    Rails.logger.debug { "context.cell #{context.cell.inspect}" }
  end
end
