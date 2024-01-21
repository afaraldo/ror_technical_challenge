class SendEmailToAdmins
  include Sidekiq::Worker

  def perform(name, count)
    puts "Haciendo un trabajo para #{name} #{count} veces"
  end
end