require 'date'

# rubocop:disable Documentation
class Chef
  class Resource
    class UserShadow < Chef::Resource
      provides :user_shadow

      def initialize(name, run_context = nil)
        super
        @resource_name = :user_shadow
        @user = @name
        @allowed_actions = :set
        @action = :set
        @chage = '/usr/bin/chage'
        @sp_lstchg, @sp_expire, @sp_min, @sp_max, @sp_warn, @sp_inact = nil
      end

      def user(arg = nil)
        set_or_return(:user, arg, kind_of: String)
      end

      def chage(arg = nil)
        set_or_return(:chage, arg, kind_of: String)
      end

      def sp_lstchg(arg = nil)
        set_or_return(:sp_lstchg, arg, kind_of: String, callbacks: { 'should be a date in YYYY-MM-DD format' => ->(date) { Chef::Resource::UserShadow.validate_date(date) } })
      end

      def sp_expire(arg = nil)
        set_or_return(:sp_expire, arg, kind_of: String, callbacks: { 'should be a date in YYYY-MM-DD format' => ->(date) { Chef::Resource::UserShadow.validate_date(date) } })
      end

      def sp_min(arg = nil)
        set_or_return(:sp_min, arg, kind_of: Integer)
      end

      def sp_max(arg = nil)
        set_or_return(:sp_max, arg, kind_of: Integer)
      end

      def sp_warn(arg = nil)
        set_or_return(:sp_warn, arg, kind_of: Integer)
      end

      def sp_inact(arg = nil)
        set_or_return(:sp_inact, arg, kind_of: Integer)
      end

      # Used to validate sp_lstchg and sp_expire which should be in YYYY-MM-DD
      def self.validate_date(date)
        !Date.strptime(date, '%Y-%m-%d').nil?
      rescue
        false
      end
    end
  end
end
# rubocop:enable Documentation
