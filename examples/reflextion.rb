require 'set'
DIR1 = '../rest2'.freeze
DIR2 = '../lib/twilio-ruby/rest'.freeze

def get_paths(dir)
  paths = Set['']
  Dir["#{dir}/**/*.rb"].sort.each do |file|
    paths.add(file[dir.length + 1, file.length])
  end
  Dir["#{dir}/*.rb"].sort.each do |file|
    paths.add(file[dir.length + 1, file.length])
  end
  paths
end

def check_if_all_files_same(dir1, dir2)
  paths1 = get_paths dir1
  paths2 = get_paths dir2
  if paths1 == paths2
    puts "Both #{dir1} and #{dir2} have exactly same files"
  else
    puts 'there is a difference between both folders'
    puts "Files #{dir1} have that #{dir2} don't are #{paths1 - paths2}"
    puts "Files #{dir2} have that #{dir2} don't are #{paths2 - paths1}"
  end
end

def require_necessary
  Dir["#{File.expand_path('..', Dir.pwd)}/lib/twilio-ruby/framework/rest/**/*.rb"].sort.each do |file|
    load file
  end
end

def require_dir(dir)
  Dir["#{dir}/**/*.rb"].sort.each do |file|
    load file
  end
  Dir["#{dir}/*.rb"].sort.each do |file|
    load file
  end
end

require_necessary
def get_class_properties(class_name)
  return ['@solution'] if class_name.instance_of?(Class) && (class_name < Twilio::REST.const_get('Page'))

  arity = if class_name.instance_method(:initialize).arity >= 0
            class_name.instance_method(:initialize).arity
          else
            class_name.instance_method(:initialize).parameters.select { |necessity, _| necessity == :req }.length
          end
  begin
    class_name.new(*Array.new(arity).fill { |_| {} }).instance_variables
  rescue Exception
    p []
  end
end

def get_method_data(resource)
  methods = resource.public_instance_methods(true) - resource.superclass.public_instance_methods(true)
  method_data = methods.to_h do |m|
    method = resource.public_instance_method(m)
    [m.to_s, [
      "params": method.parameters
    ]]
  end
  method_data[:initialize] = [{ "params": resource.method(:initialize).parameters }]
  method_data
end

def parse_resources(resources)
  resources.to_h do |resource|
    res = resource.constants.select do |constant|
      resource.const_get(constant).is_a? Class and
        (resource.const_get(constant) < Twilio::REST.const_get('Page') or
        resource.const_get(constant) < Twilio::REST.const_get('ListResource') or
        resource.const_get(constant) < Twilio::REST.const_get('InstanceResource') or
        resource.const_get(constant) < Twilio::REST.const_get('InstanceContext'))
    end.map { |re| resource.const_get(re) }

    methods = get_method_data(resource)
    properties = get_class_properties(resource)
    res_data = if !res.empty?
                 parse_resources(res)
               else
                 {}
               end
    type = if resource < Twilio::REST.const_get('Page')
             'Page'
           elsif resource < Twilio::REST.const_get('InstanceResource')
             'InstanceResource'
           elsif resource < Twilio::REST.const_get('ListResource')
             'ListResource'
           else
             'InstanceContext'
           end
    [resource.to_s, Hash[
      'type' => type,
      'methods' => methods,
      'children' => res_data,
      'properties' => properties
    ]]
  end
end

def parse_versions(domain)
  versions = domain.constants.select do |constant|
    domain.const_get(constant) < Twilio::REST.const_get('Version')
  end
  versions.to_h do |v|
    version = domain.const_get(v)
    resources = version.constants.select do |constant|
      version.const_get(constant) < Twilio::REST.const_get('Page') or
        version.const_get(constant) < Twilio::REST.const_get('ListResource') or
        version.const_get(constant) < Twilio::REST.const_get('InstanceResource') or
        version.const_get(constant) < Twilio::REST.const_get('InstanceContext')
    end.map { |resource| version.const_get(resource) }
    resource_data = parse_resources(resources)
    properties = get_class_properties(version)
    methods = get_method_data(version)
    [v.to_s, Hash[
  'type' => 'Version',
  'children' => resource_data,
  'methods' => methods,
  'properties' => properties
  ]]
  end
end

def parse_domains(dir)
  require_dir(dir)
  include Twilio::REST
  domains = Twilio::REST.constants.select do |constant|
    Twilio::REST.const_get(constant) < Twilio::REST.const_get('Domain')
  end
  domains_data = domains.to_h do |d|
    domain = Twilio::REST.const_get(d)
    versions = parse_versions(domain)
    methods = get_method_data(domain)
    properties = get_class_properties(domain)
    [d.to_s, Hash[
      'type' => 'Domain',
      'children' => versions,
      'methods' => methods,
      'properties' => properties
    ]]
  end
  Object.send(:remove_const, :Twilio)
  domains_data
end

def compare_properties(prop1, prop2, path)
  return unless prop1.length != prop2.length

  puts "There is a discrepancy in properties at path #{path}"
  puts "Properties in case 1 are #{prop1}"
  puts "Properties in case 2 are #{prop2}"
end

def compare_methods(method1, method2, path)
  if method1.keys != method2.keys
    puts "There is a discrepancy in methods at path #{path}"
    puts "Methods 1 - Methods 2 = #{method1.keys - method2.keys}"
    puts "Methods 2 - Methods 1 = #{method2.keys - method1.keys}"
  end
  method1.each do |method_name, method_args|
    unless method2.key?(method_name)
      puts "There is a discrepancy in methods in #{method_name} at path #{path}"
      next
    end
    next unless method_args != method2[method_name]

    puts "There is a discrepancy in parameters of methods in #{method_name} at path #{path}"
    puts "Methods 1 args - Methods 2 args = #{method_args - method2[method_name]}"
    puts "Methods 2 args - Methods 1 args = #{method2[method_name] - method_args}"
  end
end

def compare_children(resources1, resources2, path)
  if resources1.size != resources2.size
    puts "There is a discrepancy in resources in path #{path}"
    puts "Resource 1 - Resource 2 is #{resources1.keys - resources2.keys}"
    puts "Resource 2 - Resource 1 is #{resources2.keys - resources1.keys}"
  end
  resources1.each do |resource_name, resource_value|
    unless resources2.key?(resource_name)
      puts "In path #{path} resource #{resource_name} not found"
      next
    end
    resource_path = resource_name.include?('::') ? resource_name : "#{path}::#{resource_name}"
    compare_properties(resource_value['properties'], resources2[resource_name]['properties'], resource_path)
    compare_methods(resource_value['methods'], resources2[resource_name]['methods'], resource_path)
    compare_children(resource_value['children'], resources2[resource_name]['children'], resource_path)
  end
end

# keep domains 1 as correct and domains 2 as need to be checked
def compare_domain_data(domains1, domains2)
  if domains1.keys.size != domains2.keys.size
    puts 'There number of domain differ in domains 1 and 2'
    puts "Domains in 1 are #{domains1.keys}"
    puts "Domains in 2 are #{domains2.keys}"
  end
  domains1.each do |domain_name, domain_value|
    unless domains2.key?(domain_name)
      puts "#{domain_name} not found in domain 2"
      next
    end
    compare_properties(domain_value['properties'], domains2[domain_name]['properties'], domain_name)
    compare_methods(domain_value['methods'], domains2[domain_name]['methods'], domain_name)
    compare_children(domain_value['children'], domains2[domain_name]['children'], domain_name)
  end
  warn 'The compare_domain_data has finished running'
end

# Here you can see working of the  reflection tests example given below
# Here DIR1 and DIR2 has been set at the top, DIR1 is currently the one needed to be tested Dir2 is correct version
# Keep the reflection.rb files in twilio-ruby/examples folder(examples folder inside root of project and set from there)
# Currently changes have been made to rest2 folder i.e. DIR1 to check against DIR2
# to run the test go to examples and run "ruby reflection.rb" currently tested in ruby 3.1.3
domains1 = parse_domains(DIR1)
domains2 = parse_domains(DIR2)
compare_domain_data(domains1, domains2)

# Test to check if file are same has also been. Eg given below
# check_if_all_files_same(DIR1,DIR2)
