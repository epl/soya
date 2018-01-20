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

require 'date' # Workaround for safe_yaml bug, see: <https://github.com/dtao/safe_yaml/issues/80>
require 'json'
require 'safe_yaml'

require 'soya/actions'
require 'soya/cli_parser'
require 'soya/error'

module Soya
  @@options = {}

  def self.options
    @@options
  end

  def self.load(filename, format)
    fd = (filename == '-') ? $stdin : File.open(filename, 'rb')
    contents = fd.read

    if (format == :json)
      return JSON.load(contents)
    elsif (format == :yaml || format == :yml)
      return YAML.load(contents)
    else
      ## The CLI parser should stop this from occurring.
      raise Soya::Error.new("impossible input format: #{format.to_s}")
    end
  end

  def self.verbose(message)
    if Soya.options[:verbose]
      $stderr.puts message
    end
  end

  def self.json_type(x)
    if Hash === x
      return :hash
    elsif Array === x
      return :array
    else
      # string, number, boolean, null
      return :scalar
    end
  end

  def self.merge_strategy(key, v1, v2)
    display_key = (key.size == 0) ? '.' : key
    type_v1 = json_type(v1)
    type_v2 = json_type(v2)

    if type_v1 == type_v2
      if type_v1 == :hash
        return v1.merge(v2) { |key2, oldval, newval| merge_strategy("#{key}.#{key2}", oldval, newval) }
      elsif type_v1 == :array
        if Soya.options[:strict]
          raise Soya::Error.new("clashing arrays values (path: #{key}): #{v2} appended to #{v1}")
        else
          return v1 + v2
        end
      else
        if Soya.options[:strict]
          raise Soya::Error.new("duplicate scalar values (path: #{key}): \"#{v2}\" replacing \"#{v1}\"")
        else
          return v2
        end
      end
    else
      raise Soya::Error.new("type conflict (path: #{key}): #{type_v1} vs #{type_v2}")
    end
  end

  def self.deep_clone(obj)
    ## This breaks YAML anchors/references.
    Marshal.load(Marshal.dump(obj))
  end

  def self.run
    begin
      SafeYAML::OPTIONS[:default_mode] = :safe

      parser = Soya::CliParser.new(ARGV)
      @@options = parser.options
      args = parser.args

      filenames = (args + options[:define]).empty? ? ['-'] : args
      file_hashes = filenames.empty? ? {} : filenames.map { |filename| load(filename, options[:from]) }.reduce() { |memo,obj| merge_strategy('', memo, obj) }

      actions = [
        { :class => Soya::Action::Definition, :param => options[:define]    },
        { :class => Soya::Action::Copying,    :param => options[:copy]      },
        { :class => Soya::Action::Extraction, :param => options[:extract]   },
        { :class => Soya::Action::Deletion,   :param => options[:delete]    },
        { :class => Soya::Action::Insertion,  :param => options[:insert]    },
        { :class => Soya::Action::Canonical,  :param => options[:canonical] },
        ## Soya::Action::Output class must be last because its #result is a String not a Hash.
        { :class => Soya::Action::Output,     :param => options[:to]        },
      ]
      puts actions.reduce(file_hashes) { |memo, action| action[:class].new(action[:param], memo).result }
    rescue Soya::Error => e
      $stderr.puts "#{File.basename($PROGRAM_NAME)}: #{e.to_s}"
      verbose(e.backtrace)
      exit e.return_code
    end
  end
end
