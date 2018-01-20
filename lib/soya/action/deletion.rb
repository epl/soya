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

require 'soya'
require 'soya/error'
require 'soya/path'

module Soya
  module Action
    class Deletion
      attr_reader :result

      def initialize(paths, hash)
        paths.each do |path|
          hash = remove(path, Soya::deep_clone(hash))
        end
        @result = hash
      end

      private

      def remove(path, hash)
        last = hash
        components = Soya::Path.new(path).components
        last_index = components.length-1
        components.each_index do |i|
          key = components[i]
          last_element = (i >= last_index)
          if Hash === last && last.has_key?(key)
            if last_element
              last.delete(key)
            else
              last = last[key]
            end
          elsif Array === last && match = /^\[(?<index>\d+)\]$/.match(key) ## && match[:index].to_i < last.length
            if last_element
              last.delete_at(match[:index].to_i)
            else
              last = last[match[:index].to_i]
            end
          else
            raise Soya::Error.new("error: invalid deletion key: #{key}")
          end
        end
        return hash
      end
    end # Deletion
  end # Action
end # Soya
