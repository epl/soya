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
    class Extraction
      attr_reader :result

      def initialize(path, hash)
        last = Soya::deep_clone(hash)
        Soya::Path.new(path).components.each do |key|
          if Hash === last && last.has_key?(key)
            last = last[key]
          elsif Array === last && match = /^\[(?<index>\d+)\]$/.match(key)
            last = last[match[:index].to_i]
          else
            raise Soya::Error.new("error: invalid extraction key: #{key}")
          end
        end
        @result = last
      end
    end # Extraction
  end # Action
end # Soya
