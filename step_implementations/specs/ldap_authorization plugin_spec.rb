step 'ldap - start creating new auth config with id <id>' do |id|
  authorization_config_page.click_add
  ldap_authorization_plugin_auth_config_modal.id.set(id, rapid: false)
  ldap_authorization_plugin_auth_config_modal.plugin_id.select 'LDAP Authorization Plugin for GoCD'
  ldap_authorization_plugin_auth_config_modal.url.set("ldap://#{GoConstants::LDAP_SERVER_IP}", rapid: false)
end

step 'ldap - set manager dn <manager_dn>' do |manager_dn|
  ldap_authorization_plugin_auth_config_modal.manager_dn.set(manager_dn, rapid: false)
end

step 'ldap - set password <password>' do |password|
  ldap_authorization_plugin_auth_config_modal.password.set(password, rapid: false)
end

step 'ldap - set search bases <search_bases>' do |search_bases|
  ldap_authorization_plugin_auth_config_modal.search_bases.set(search_bases, rapid: false)
end

step 'ldap - set login filter <login_filter>' do |login_filter|
  ldap_authorization_plugin_auth_config_modal.user_login_filter.set(login_filter, rapid: false)
end

step 'ldap - set user name attribute <user_name_attribute>' do |user_name_attribute|
  ldap_authorization_plugin_auth_config_modal.user_name_attribute.set(user_name_attribute, rapid: false)
end

step 'ldap - start creating a new plugin role <role_name> with auth config <auth_config_id>' do |role_name, auth_config_id|
  role_config_page.click_add
  role_config_page.plugin_role = true
  ldap_authorization_plugin_role_config_modal
  ldap_authorization_plugin_role_config_modal.name.set(role_name, rapid: false)
  ldap_authorization_plugin_role_config_modal.auth_config_id.select "#{auth_config_id} (LDAP Authorization Plugin for GoCD)"
end

step 'ldap - set group membership attribute <attribute>' do |attribute|
  ldap_authorization_plugin_role_config_modal.group_membership_attribute.set(attribute, rapid: false)
end

step 'ldap - set group identifiers <group_identifiers>' do |group_identifiers|
  ldap_authorization_plugin_role_config_modal.group_identifiers.set(group_identifiers, rapid: false)
end

step 'ldap - set group search bases <group_search_bases>' do |group_search_bases|
  ldap_authorization_plugin_role_config_modal.group_search_bases.set(group_search_bases, rapid: false)
end

step 'ldap - set group membership filter <group_membership_filter>' do |group_membership_filter|
  ldap_authorization_plugin_role_config_modal.group_membership_filter.set(group_membership_filter, rapid: false)
end