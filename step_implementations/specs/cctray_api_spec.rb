
step 'Make API call to cctray feed' do ||
    RestClient.get http_url("/cctray.xml"), basic_configuration.header do |response|
      cctray_response = Nokogiri::XML(response)
      scenario_state.put('cctray_response',cctray_response)
    end
end


step 'Verify cctray feed contains stage <stage> with current activity <current_activity> with label <label> and last status <last_status> with broken by authors of last commit for material <material> of type <type> for pipeline <pipeline>' do |stage,current_activity,label,last_status,material,type,pipeline|
  doc=scenario_state.get('cctray_response')
  current_material_url=basic_configuration.material_url(pipeline,type,material)
  latest_revision=Context::GitMaterials.new(current_material_url).latest_revision
  author=Context::GitMaterials.new(current_material_url).auther_name latest_revision
  project_node=doc.xpath("//Project[@name='#{scenario_state.get(pipeline)} :: #{stage}'] [@lastBuildLabel='#{label}']")
  assert_equal project_node.attr('lastBuildStatus').value,last_status
  assert_equal project_node.attr('activity').value,current_activity
  assert_true author.include? project_node.xpath('//messages/message').first.attr('text')
end


step 'Verify cctray feed contains stage <stage> job <job> with current activity <current_activity> with label <label> and last status <last_status> with broken by authors of last commit for material <material> of type <type> for pipeline <pipeline>' do |stage,job,current_activity,label,last_status,material,type,pipeline|
  doc=scenario_state.get('cctray_response')
  current_material_url=basic_configuration.material_url(pipeline,type,material)
  latest_revision=Context::GitMaterials.new(current_material_url).latest_revision
  author=Context::GitMaterials.new(current_material_url).auther_name latest_revision
  project_node= doc.xpath("//Project[@name='#{scenario_state.get(pipeline)} :: #{stage} :: #{job}'] [@lastBuildLabel='#{label}']")
  assert_equal project_node.attr('lastBuildStatus').value,last_status
  assert_equal project_node.attr('activity').value,current_activity
  assert_true author.include? project_node.xpath('//messages/message').first.attr('text')
end
step 'Verify cctray feed contains stage <stage> with relative weburl <weburl> with lablel <label>' do |stage,weburl,label|
  doc=scenario_state.get('cctray_response')
  project_node= doc.xpath("//Project[@name='#{scenario_state.self_pipeline} :: #{stage}'] [@lastBuildLabel='#{label}']")
  assert_true project_node.attr('webUrl').value.include?weburl
end

step 'Verify cctray feed contains stage <stage> and job <job> with relative weburl <weburl> with lablel <label>' do |stage,job,weburl,label|
  doc=scenario_state.get('cctray_response')
  project_node= doc.xpath("//Project[@name='#{scenario_state.self_pipeline} :: #{stage} :: #{job}'] [@lastBuildLabel='#{label}']")
  assert_true project_node.attr('webUrl').value.include?weburl
end


step 'Verify cctray feed contains stage <stage> job <job> with current activity <current_activity> with label <label> and last status <last_status>' do |stage,job,current_activity,label,last_status|
  doc=scenario_state.get('cctray_response')
  project_node= doc.xpath("//Project[@name='#{scenario_state.self_pipeline} :: #{stage} :: #{job}'] [@lastBuildLabel='#{label}']")
  assert_equal project_node.attr('lastBuildStatus').value,last_status
  assert_equal project_node.attr('activity').value,current_activity
end

step 'Verify cctray feed contains stage <stage> with current activity <current_activity> with label <label> and last status <last_status>' do |stage,current_activity,label, last_status|
  doc=scenario_state.get('cctray_response')
  project_node= doc.xpath("//Project[@name='#{scenario_state.self_pipeline} :: #{stage}'] [@lastBuildLabel='#{label}']")
  assert_equal project_node.attr('lastBuildStatus').value,last_status
  assert_equal project_node.attr('activity').value,current_activity
end

step 'Verify cctray does not contain pipeline <pipeline> with stage <stage>' do |pipeline,stage|
  doc=scenario_state.get('cctray_response')
  assert_true doc.xpath("//Project[@name='#{scenario_state.get(pipeline)} :: #{stage}']").empty?
end
