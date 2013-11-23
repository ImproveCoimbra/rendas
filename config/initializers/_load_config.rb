CONFIG  = YAML::load(ERB.new(IO.read(File.join(Rails.root.to_s, 'config', 'config.yml'))).result)[Rails.env]
