PID_FILE = "__pid__"

class String

  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"  
  end

  def red
    self.class.colorize(self, 31);
  end
  
  def green
    self.class.colorize(self, 32)
  end
  
  def yellow
    self.class.colorize(self, 33)
  end
  
  def cyan
    self.class.colorize(self, 36)
  end
  
end

class GivingSocially
  attr_accessor :verbose
  attr_reader :build_dir
  
  def self.instance 
    @instance ||= GivingSocially.new
  end
  
  def initialize
    @verbose = ENV['VERBOSE'] || false
  end
  
  def verbose?
    self.verbose
  end
  
  def run(command, exit_on_failure = true)
    require 'rubygems'
    require 'open4'
    output_buffer = []
    puts "Executing `#{command}`"
    status = Open4::popen4(command) do |pid, stdin, stdout, stderr|
      stdout.each_line do |line|
        if line =~ /BUILD_DIR\s/
          unless @build_dir
             @build_dir ||= line.split(/BUILD_DIR\s/).last.chomp
             puts "*** Found build directory: #{@build_dir}" 
          end
        end
        if verbose?
          puts line
        else
          output_buffer << line
        end
      end
    end
    
    if exit_on_failure and status.exitstatus != 0 
      puts "Exited with status: #{ status.exitstatus }. Displaying last 25 lines of output..."
      puts output_buffer.last(25).join("\n")
      exit($?.exitstatus) if exit_on_failure
    end
    
    return status.exitstatus
  end

  def execute(title, command)
    require 'rubygems'
    require 'open4'
    
    puts title.cyan
    puts command
    status = Open4::popen4(command) do |pid, stdin, stdout, stderr| 
      stdout.each_line do |line|
        puts line.yellow
      end
    end
    
    puts "Complete.".red
    
    return status.exitstatus    
  end
end

task :default => 'build:release'

namespace :build do

  desc "Build the release version of App"
  task :release do
    builder = GivingSocially.new
    builder.run("xcodebuild -project Code/GivingSocially.xcodeproj/ -scheme GivingSocially")
  end

  desc "Build the calabash test version of App"
  task :tests do
    builder = GivingSocially.new
    builder.run("xcodebuild -project Code/GivingSocially.xcodeproj/ -scheme GivingSocially-calabash -sdk iphonesimulator6.0 -configuration Debug build")
  end
end

desc "Testing - Run complete test on the App"
task :test => 'test:calabash_phone'

namespace :test do 

  desc "Calabash Tests for iPhone"
  task :calabash_phone => ['build:tests'] do
    ENV['DEVICE']='iphone'
    ENV['OS']='ios6'
    system "cd Code && cucumber"
  end

  desc "Calabash Tests for iPad"
  task :calabash_pad => ['build:tests'] do
    ENV['DEVICE']='ipad'
    ENV['OS']='ios6'
    system "cd Code && cucumber"
  end
  
end

desc "Generate the model files from Core Data (uses selected version)"
task :mogen do
  model_path = "Code/GivingSocially/Models/GSDataModel.xcdatamodeld"
  current_version_of_model = `/usr/libexec/PlistBuddy "#{model_path}/.xccurrentversion" -c "print _XCCurrentVersionName"`.chomp
  current_version_of_model_path = "#{model_path}/#{current_version_of_model}"
  GivingSocially.instance.execute("Generating NSManagedObjectModel Sub-classes with model:\n#{current_version_of_model_path}\n", "mogenerator --model \"#{current_version_of_model_path}\"  --machine-dir \"Code/GivingSocially/Models/Machine\" --human-dir \"Code/GivingSocially/Models\" --template-var arc=true")
end