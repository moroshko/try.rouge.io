require 'rouge'
require 'fakefs/safe'
require 'stringio'

class ShellController < ApplicationController
  def index
  end

  def execute
    command = params[:command]

    code = <<-RUBY
    # FakeFS::FileSystem.clear
    def Kernel.require(path)
      false
    end
    $SAFE = 3
    begin
      context = Rouge::Context.new Rouge[:user]
      context.readeval(#{command.inspect})
    end
    RUBY

    Rouge.boot!
    FakeFS.activate!
    stdout_id = $stdout.to_i
    $stdout = StringIO.new

    begin
      result = Thread.new { eval code, TOPLEVEL_BINDING }.value
    rescue SecurityError
      return render :json => {:ok => false, :error => "SecurityError"}
    rescue Exception => e
      return render :json => {:ok => false, :error => "#{e.inspect}"}
    ensure
      stdout = get_stdout
      $stdout = IO.new(stdout_id)
      FakeFS.deactivate!
    end

    render :json => {:ok => true, :message => "#{stdout}#{Rouge.print(result, "".dup)}"}
  end

  private

  def get_stdout
    raise TypeError, "not a StringIO" unless $stdout.is_a? StringIO
    $stdout.rewind
    $stdout.read
  end
end

# vim: set et sw=2 cc=80:
