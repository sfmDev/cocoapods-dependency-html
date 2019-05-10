module Pod
  class Command
    class Dependency < Command
      include Command::ProjectDirectory

      self.summary = 'Help you know your project dependecncies with HTML file.'

      self.description = <<-DESC
        Shows the project's dependency.
      DESC

      def self.arguments
        [
          CLAide::Argument.new('NAME', false)
        ].concat(super)
      end

      def self.options
          [
            ['--use-tree', 'Whether the equal level dependencies use tree'],
          ].concat(super)
        end

      def initialize(argv)
        @name = argv.shift_argument

        @use_tree = argv.flag?('use-tree', false)
        @dependencies_regular_hash = Hash.new

        @dependency_names = Array.new
        @dependencies_hash = Hash.new
        @dependencies_tree_levels = Array.new
        @dependencies_level_hash = Hash.new


        @output_dependencies_hash = Hash.new
        @output_dependencies_hash["nodes"] = []
        @output_dependencies_hash["edges"] = []
        super
      end

      def validate!
        super
        puts @name
      end

      def read_config
        if File::exist?("./dependency_config")
          file = File.open("./dependency_config", 'r')
          @dependencies_regular_hash = JSON.load(file.read())
          return true
          if !@dependencies_regular_hash
            puts "dependency_config file cannot be converted to JSONObject"
            return false
          end
        else
          puts "Please add json file named dependency_config in project root path"
          return false
        end
      end

      def run
        is_success = read_config
        if !is_success
          return
        end

        UI.title "Calculating dependencies" do
          dependencies
        end

        UI.title 'Dependencies' do
          dependencies.map { |dep|
            if dep.is_a? Hash
              dep_hash = dep.to_h
              key = remove_version(dep_hash.keys.first)
              @dependencies_hash.store(key, dep_hash[dep_hash.keys.first])
              @dependency_names << key
            else
              @dependencies_hash.store(remove_version(dep), dep)
              @dependency_names << remove_version(dep)
            end
          }

          if @name
            UI.title "#{@name} Dependencies" do
              puts @dependencies_hash["#{@name}"]
            end
          end

          modules_arr = Array.new
          @dependencies_regular_hash.each {
	           modules_arr << []
          }
          modules_arr << []

          @dependency_names.map { |dep|
          	temp_dep = get_pod_name(dep)
          	has_add = false
          	for i in 0..@dependencies_regular_hash.keys.count-1
          	  key = @dependencies_regular_hash.keys[i]
          	  regular_expression = @dependencies_regular_hash[key]
          		if temp_dep =~ /#{regular_expression}/
          		  	modules_arr[i] << dep
          			has_add = true
          			break
          		end
          	end
          	if !has_add
              if !is_subspec(dep)
                modules_arr.last << dep
              end
          	end
          }

          p modules_arr

          if @use_tree
            for arr in modules_arr
              split_modoule_with_tree(arr)
            end
          end

          root_sourceId = get_project_name
          add_root(root_sourceId, modules_arr[0].count)

          if @use_tree
            for i in 0..@dependencies_tree_levels.count - 1
              ## i == level
              for j in 0..@dependencies_tree_levels[i].count-1
                ## j == pod_name
                pod_name = @dependencies_tree_levels[i][j]
                if pod_name != nil || pod_name.class == String || pod_name.length > 0
                  add_tree_node(pod_name, get_pod_size(pod_name), j, i, j % 2 == 0)
                end
              end
            end

            ## add root -> first level egde
            for pod_name in modules_arr[0]
              add_edge(root_sourceId, remove_version(pod_name))
            end

          else
            for j in 0..modules_arr.count-1
              pod_arr = modules_arr[j]
              for i in 0..pod_arr.count-1
                 pod_name = pod_arr[i]
                 add_node(pod_arr[i], get_pod_size(pod_name), i, j+1, i % 2 == 0)
                 if j == 0
                   add_edge(root_sourceId, remove_version(pod_arr[i]))
                 end
              end
            end
          end

          @dependencies_hash.each { |key,value|
            if value.class == Array
               for i in 0..value.count - 1
                 pod = value[i]
                 if key != value[i]
                   add_edge(key, remove_version(pod))
                 end
               end
            end
          }

          p `rm -rf pod_dependency.json`
          p `touch pod_dependency.json`
          File.open("./pod_dependency.json","w") do |f|
            dep_json = JSON @output_dependencies_hash
            f.write("index(" + dep_json + ")")

            require 'yaml'
            require 'launchy'
            p `rm -rf dependency_graph.html`
            p `wget https://raw.githubusercontent.com/sfmDev/cocoapods-dependency/master/lib/cocoapods-dependency/front-end/dependency_graph.html`
            Launchy.open("./dependency_graph.html")
          end
        end
      end

      def split_modoule_with_tree modules
      	for pod in modules
      	   dep_array = @dependencies_hash[pod]

      	   if dep_array.is_a? Array
             dep_array.map! { |pod_name|
               remove_version(pod_name)
             }
      	     for i in 0..dep_array.count-1
      	       if modules.include?(dep_array[i])
      	          record_each_be_dependencied(dep_array[i])
      	       end
      	     end
      	   end
      	end

        temp_modules_dep = @dependencies_level_hash.keys.flatten
        first_level_arr = modules - temp_modules_dep

        @dependencies_tree_levels << first_level_arr

        clean_record
        if temp_modules_dep.count > 0
          split_modoule_with_tree(temp_modules_dep)
        end
      end

      def clean_record
        @dependencies_level_hash.clear
      end

      def record_each_be_dependencied pod_name
        if @dependencies_level_hash[pod_name]
          @dependencies_level_hash[pod_name] = 2
        else
          @dependencies_level_hash[pod_name] = 1
        end
      end

      def get_pod_level pod_name
        if @dependencies_level_hash[pod_name]
          return @dependencies_level_hash[pod_name]
        else
          return 1
        end
      end

      def sperate_modules_with_level module_names
        pod_sperate_arr = Array.new
        pod_sperate_hash = Hash.new
        for pod in module_names
          level = get_pod_level(pod)
          current_pods = pod_sperate_hash[level]
          current_pods = current_pods.to_s + "," + pod
          pod_sperate_hash[level] = current_pods
        end

        pod_sperate_hash.each { |key,value|
          index = key
          pods = value.split(",")
          pod_sperate_arr[index] = pods.delete_if { |item| item == nil || item.class != String || item.length == 0}
        }
        return pod_sperate_arr
      end

      def get_project_name
        path = `pwd`
        return path.split("/").last
      end

      def get_pod_size pod_name
        if @use_tree
          return 15
        else
          if @dependencies_hash["#{pod_name}"].class == Array
            return 10
          else
            return 10
          end
        end
      end

      def remove_version pod_name
          if pod_name.include? " "
            return pod_name.split(" ").first
          end
          pod_name
      end

      def get_pod_dependency pod_name
        return @dependencies_hash[pod_name]
      end

      def get_pod_name pod
        pod_name_subspec = remove_version(pod)
        if pod_name_subspec.include? "/"
          return pod_name_subspec.split("/").first
        end
        pod_name_subspec
      end

      def is_subspec pod_name
          if pod_name.include? "/"
            return true
          end
  	      return false
      end

      def add_root(pod_name, size)
          node = Hash.new
          node["color"] = "#4f19c7"
          node["label"] = pod_name
          node["attributes"] = {}
          node["y"] = -2000
          node["x"] = 200
          node["id"] = pod_name
          node["size"] = size
          @output_dependencies_hash["nodes"] << (node)
      end

      def get_tree_level_color pod_name

      end

      def get_level_color level
          if level == 0
            return "#F75855"
          elsif level == 1
            return "#EC944B"
          elsif level == 2
            return "#ACD543"
          elsif level == 3
            return "#45D5AA"
          elsif level == 4
            return "#EB1E0F"
          else
            return "#45D5AA"
          end
      end

      def add_tree_node(pod_name, size, index, depth, is_left)
          node = Hash.new
          node["color"] = get_level_color(depth)
          node["label"] = pod_name
          node["attributes"] = {}
          node["y"] = -2000 + (depth + 1) * 1500

          if is_left
            node["x"] = 0 + (index + 1) * 400
          else
            node["x"] = 0 - index * 400
          end

          node["id"] = pod_name
          node["size"] = size
          @output_dependencies_hash["nodes"] << (node)
      end

      def add_node(pod_name, size, index, level, is_left)
          node = Hash.new
          node["color"] = get_level_color(level)
          node["label"] = pod_name
          node["attributes"] = {}
          node["y"] = -2000 + level * 3000
          if is_left
            node["x"] = 0 + (index + 1) * 200
          else
            node["x"] = 0 - index * 200
          end

          node["id"] = pod_name
          node["size"] = size
          @output_dependencies_hash["nodes"] << (node)
      end

      def add_edge(source_id, target_id)
          edge = Hash.new
          edge["sourceID"] = source_id
          edge["targetID"] = target_id
          edge["attributes"] = {}
          edge["size"] = 1
          @output_dependencies_hash["edges"] << (edge)
      end

      def dependencies
        @dependencies ||= begin
          lockfile = config.lockfile unless @ignore_lockfile || @podspec

          if !lockfile || @repo_update
            analyzer = Installer::Analyzer.new(
              sandbox,
              podfile,
              lockfile
            )

            specs = config.with_changes(skip_repo_update: !@repo_update) do
              analyzer.analyze(@repo_update || @podspec).specs_by_target.values.flatten(1)
            end

            lockfile = Lockfile.generate(podfile, specs, {})
          end

          lockfile.to_hash['PODS']
        end
      end

    end
  end
end
