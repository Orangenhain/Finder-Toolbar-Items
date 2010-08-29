task :build_droplet, [:dest_dir] do |task, args|
  if (args.dest_dir.nil? or not File.directory?(args.dest_dir))
    puts "invalid destination: #{args.dest_dir}"
    exit 1
  end
  
  source_dir = File.basename(__FILE__, File.extname(__FILE__))
  Dir.chdir(source_dir)
  success = system("xcodebuild clean")
  exit 2 unless success
  success = system("xcodebuild build")
  exit 3 unless success
  Dir.chdir(Dir.getwd + "/..")
  success = system("ditto \"#{source_dir}/build/Release/OpenTerminalHere.app\" \"#{args.dest_dir}/#{source_dir}.app\"")
  exit 4 unless success
  `rm -rf \"#{source_dir}/build\"`
end
