module Fik
  class Configuration
    def initialize(folder)
      @folder = folder
    end
    
    def build
      Dir.glob("#{@folder}/*").inject({}) do |memo, subfolder|
        type = File.basename(subfolder)
        memo[type] = Dir.glob("#{subfolder}/*.yml").inject({}) do |set, file|
          name = File.basename(file).split(".")[0]
          set[name] = YAML.load_file(file)
          set[name]["name"] = name
          set
        end
        memo
      end
    end
  end
end