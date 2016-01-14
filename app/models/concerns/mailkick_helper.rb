module MailkickHelper
  extend ActiveSupport::Concern

  def opted_out?(options = {})
    Mailkick.opted_out?({email: email, user: self}.merge(options))
  end

  def opt_out(options = {})
    Mailkick.opt_out({email: email, user: self}.merge(options))
  end

  def opt_in(options = {})
    Mailkick.opt_in({email: email, user: self}.merge(options))
  end

  module ClassMethods
    def opted_out(options = {})
      ids = Mailkick::OptOut.where(user_type: self.name, active: true, list: options[:list]).pluck(:user_id)
      find_users(ids, options)
    end

    def not_opted_out(options = {})
      opted_out(options.merge(not: true))
    end

    private

    def find_users(ids, options = {})
      users = find(:all, options).to_a
      filter = Proc.new{ |user| ids.include?(user.id) }
      options[:not] ? users.delete_if(&filter) : users.keep_if(&filter)
    end
  end
end
