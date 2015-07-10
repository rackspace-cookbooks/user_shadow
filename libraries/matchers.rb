# Custom ChefSpec matcher for user_shadow

if defined?(ChefSpec)
  def modify_shadow_attributes(user)
    ChefSpec::Matchers::ResourceMatcher.new(:user_shadow, :set, user)
  end
end
