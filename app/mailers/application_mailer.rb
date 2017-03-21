# encoding: UTF-8
# ApplicationMailer to define main Mailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
