module CreatedBy
  extend ActiveSupport::Concern

  included do
    audited
  end

  def created_by
    audits.first.user
  end
end