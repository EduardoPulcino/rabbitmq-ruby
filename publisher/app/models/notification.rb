class Notification < ApplicationRecord
  after_save :publish!

  def publish!
    message = {
      email: email,
      subject: subject,
      content: content
    }

    BunnyClient.push(message.to_json)
  end
end
