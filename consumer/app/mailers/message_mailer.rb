class MessageMailer < ApplicationMailer
  def send_email
    @message = params[:message]

    mail(
    to: @message[:email],
    body: "Email: #{@message[:subject]}",
    content_type: "text/plain"
  )
  end
end
