before_suite do |execution_info|
  FileUtils.mkdir_p('reports') unless File.directory?('reports')
  FileUtils.rm Dir.glob('reports/*.sh')
  write_to_file('main.sh', "#!/usr/bin/env bash\nBASEDIR=$(dirname \"$0\")\n\n")
end

before_spec do |execution_info|
  if execution_info.currentSpec.nil? || execution_info.currentSpec.name.nil?
    return
  end
  lines = read_file('main.sh')

  if lines.nil? || lines.empty?
    lines = ["#!/usr/bin/env bash", 'BASEDIR=$(dirname "$0"', '']
  end

  specName = "$BASEDIR/#{execution_info.currentSpec.name}.sh"
  lines << specName unless specName.empty?

  lines.delete("\n")
  write_to_file('main.sh', lines.join("\n"))
  CurlBuilder.clearAllUrls
end

after_spec do |execution_info|
  urls = CurlBuilder.allUrls
  data = ''
  data = urls.join("\n## --------------------------- \n") unless urls.nil?
  write_to_file("#{execution_info.currentSpec.name}.sh", data)
  CurlBuilder.clearAllUrls
end

def write_to_file(filename, data)
  begin
    file = File.open("reports/#{filename}", "w+")
    file.chmod(0755)
    file.write(data)
  rescue IOError => e
  ensure
    file.close unless file.nil?
  end
end

def read_file(filename)
  File.readlines("reports/#{filename}")
end

def add_current_spec(execution_info)
  lines = read_file('main.sh')

  if lines.nil? || lines.empty?
    lines = ["#!/usr/bin/env bash", 'BASEDIR=$(dirname "$0"', '']
  end

  specName = "$BASEDIR/#{execution_info.currentSpec.name}.sh"
  lines << specName unless specName.empty?

  lines.delete("\n")
  write_to_file('main.sh', lines.join("\n"))
end