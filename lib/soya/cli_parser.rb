# soya - YAML/JSON toolkit
# Copyright (c) 2018 Edmund Lam
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'optparse'
require 'soya/version'
require 'soya/error'

module Soya
  class CliParser

    # Defaults
    @@default_options = {
      :canonical => false,
      :strict    => false,
      :from      => :yaml,
      :to        => :yaml,
      :define    => [],
      :copy      => [],
      :extract   => '',
      :delete    => [],
      :insert    => '',
      :verbose   => false
    }
    attr_reader :args
    attr_reader :options

    def initialize(args)
      @program_basename = File.basename($PROGRAM_NAME)
      @options = @@default_options

      begin
        OptionParser.new do |opt|
          opt.version = Soya::VERSION
          opt.banner = "Usage: #{@program_basename} [OPTION]... [FILE]..."
          opt.separator("\n")
          opt.on('-C', '--canonical', 'Output in a canonical order.') { |v| @options[:canonical] = v }
          # TODO: Merging is complicated and lots of potential corner cases. Keeping it simple for now (aka worse-is-better). But we could try to merge arrays.
          opt.on('-s', '--[no-]strict', 'Strict mode (error on duplicate keys)') { |v| @options[:strict] = v }
          # TODO:
          # - Support HOCON <https://github.com/typesafehub/config/blob/master/HOCON.md>
          # - Support a minified JSON as an output format.
          opt.on('-f', '--from=format', [:json, :yaml], 'Input/from file format [json, yaml (default)]') { |v| @options[:from] = v }
          opt.on('-t', '--to=format', [:json, :yaml], 'Output/to file format [json, yaml (default)]') { |v| @options[:to] = v }
          opt.separator("\n")
          opt.on('-D', '--define=PATH=EXPRESSION ...', 'Define an element') { |v| @options[:define] << v }
          opt.on('-c', '--copy=DEST=SRC ...', 'Copy a source subtree path to a destination path') { |v| @options[:copy] << v }
          opt.on('-e', '--extract=PATH', 'Output the subtree under PATH') { |v| @options[:extract] = v }
          opt.on('-d', '--delete=PATH ...', 'Deletes the subtree under PATH') { |v| @options[:delete] << v }
          opt.on('-i', '--insert=PATH', 'Insert the entire tree under PATH') { |v| @options[:insert] = v }
          opt.separator("\n")
          opt.on('-v', '--verbose', 'Verbose mode') { |v| @options[:verbose] = v }
          opt.on('-V', '--version', 'Display version') { |v| $stderr.puts opt.ver; exit 0 }
          opt.on('-h', '--help', 'Display help') { |v| $stderr.puts opt.help; exit 0 }
          opt.separator("\n")
          opt.separator('Processing order: merge, definition, copying, extraction, deletion, insertion')
          opt.separator('PATH is a dot-delimited list of keys.')
          @args = opt.parse!(args.dup)
        end
      rescue => e
        raise Soya::Error.new(e)
      end
    end

  end
end
