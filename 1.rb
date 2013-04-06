require 'yaml'

@log = YAML.load_file 'register_teacher.yml'
p @log.inspect
