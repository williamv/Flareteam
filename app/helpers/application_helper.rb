module ApplicationHelper
  def help_link
    body = <<-EOF
Dear Flareteam,

I'm having a problem using the site:

I'm not sure how to do XXX
or
I can't achieve XXX because of a problem with XXX

To assist in diagnosing the problem I have included the following details:

Login: #{current_user.try(:email) || 'Enter the email address you use for Flareteam here.'}
Organization: #{current_organization || 'Enter the name of your organization here.'}
Browser version: Enter the name of the browser you're using.
Operating system: Enter your operating system and version.

Thanks.
    EOF
    mail_to('help@flareteam.com', 'Help', subject: 'Flareteam, can you help me with a problem', body: body, id: 'help')
  end
end
