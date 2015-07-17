require 'date'
require 'shadow'

# rubocop:disable Documentation
class Chef
  class Provider
    class UserShadow < Chef::Provider
      provides :user_shadow

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        # Initialize current resource
        @current_resource = Chef::Resource::UserShadow.new(new_resource.user)
        @current_resource.user(new_resource.user)

        sp_record = ::Shadow::Passwd.getspnam(new_resource.user) # Load the user's shadow record in sp_record

        if sp_record
          # User is found in shadow file
          sp_attrs.keys.each do |sp_attr|
            if sp_attr == :sp_lstchg || sp_attr == :sp_expire
              # When pupulating the current_resource attributes that hold dates we need to convert from 'number of days since epoch' to 'YYYY-MM-DD'
              @current_resource.send(
                sp_attr.to_sym,
                Date.strptime((sp_record.send(sp_attr.to_sym) * 86_400).to_s, '%s').strftime('%Y-%m-%d')
              )
            else
              @current_resource.send(
                sp_attr.to_sym,
                sp_record.send(sp_attr.to_sym)
              )
            end
          end
        else
          # User not found
          Chef::Application.fatal!("User #{new_resource.user} not found in /etc/shadow")
        end
      end

      def action_set
        sp_attrs.each do |sp_attr, sp_attr_data|
          next unless new_resource.send(sp_attr.to_sym) && (new_resource.send(sp_attr.to_sym) != current_resource.send(sp_attr.to_sym))
          converge_by("Set #{sp_attr_data[:desc]} for user #{new_resource.user} to #{new_resource.send(sp_attr.to_sym)}") do
            chage = Mixlib::ShellOut.new(new_resource.chage, sp_attr_data[:chage_switch], new_resource.send(sp_attr.to_sym).to_s, new_resource.user)
            chage.run_command
          end
        end
      end

      def sp_attrs
        # Attributes , descriptions and chage switch
        attrs = {
          sp_lstchg: { desc: 'password last change date', chage_switch: '-d' },
          sp_expire: { desc: 'account expire date', chage_switch: '-E' },
          sp_inact:  { desc: 'days after password expire until account is disabled', chage_switch: '-I' },
          sp_min:    { desc: 'minimum days between password changes', chage_switch: '-m' },
          sp_max:    { desc: 'maximum days between password changes', chage_switch: '-M' },
          sp_warn:   { desc: 'days to warn before password expires', chage_switch: '-W' }
        }
        attrs
      end
    end
  end
end
# rubocop:enable Documentation
