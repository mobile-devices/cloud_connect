require 'bundler'
Bundler::GemHelper.install_tasks

namespace :doc do
  require 'yard'
  YARD::Rake::YardocTask.new do |task|
    task.files   = ['lib/cloud_connect.rb', 'lib/cloud_connect/**/*.rb']
    task.options = [
      '--protected',
      '--output-dir', 'doc/yard',
      '--tag', 'format:Supported formats',
      '--tag', 'authenticated:Requires Authentication',
      '--tag', 'rate_limited:Rate Limited',
      '--markup', 'markdown',
    ]
  end
end

task :irb do
  $:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
  require 'irb'
  require 'bundler/setup'
  require 'cloud_connect'
  module IRB # :nodoc:
    def self.start_session(binding)
      unless @__initialized
        args = ARGV
        ARGV.replace(ARGV.dup)
        IRB.setup(nil)
        ARGV.replace(args)
        @__initialized = true
      end

      ws  = WorkSpace.new(binding)
      irb = Irb.new(ws)

      @CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
      @CONF[:MAIN_CONTEXT] = irb.context

      catch(:IRB_EXIT) do
        irb.eval_input
      end
    end

    IRB.start_session(binding)
  end
end
