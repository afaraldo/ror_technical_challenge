class Purchases::Create
  include Interactor

  def call
    Rails.logger.debug "===---> Entering Call Purchases::Create [Interactor]"
    Rails.logger.debug { "context.purchase #{context.purchase.inspect}" }

    purchase = context.purchase

    ActiveRecord::Base.transaction do
      purchase.save
      context.fail!(message: "#{purchase.errors.full_messages}") unless purchase.save
      if Purchase.where(product_id: purchase.product_id).size == 1
        SendEmailToAdmins.perform_async(purchase.product_id)
      end
    end
  end
end
