class Email < ApplicationRecord
  def self.create_and_send(payload)
    message = new(
      email: payload['email'],
      subject: payload['subject'],
      content: payload['content']
    )

    message.save!
    send_message(message) 
  end

  def self.send_message(message)
    MessageMailer.with(message: message).send_email.deliver_now
  end
end
