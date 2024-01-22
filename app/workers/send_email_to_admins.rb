class SendEmailToAdmins
  include Sidekiq::Worker

  def perform(product_id)
    # TEMPLATE VARIABLES
    # {{{subject}}}
    # {{{product_owner}}}
    # {{{product_name}}}
    product = Product.find(product_id)

    template_id = "d-cac69ac09c2c43388c9a8f16954cf61a"
    product_owner = product.created_by

    substitutions = {
      "subject" => "Primera Venta de #{product.name} Realizada",
      "product_owner" => product_owner.email,
      "product_name" => product.name
    }
    recipent = [{ email: product_owner.email }]
    admin_emails = User.where(role_cd: 1).where('id != ?', product_owner.id).map {|user| { email: user.email} }

    ::EmailUtils.send(recipent, substitutions, template_id, admin_emails)
  end
end