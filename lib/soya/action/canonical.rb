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

module Soya
  module Action
    class Canonical
      attr_reader :result

      def initialize(conditional, hash)
        @result = conditional ? sort_hash(hash) : hash
      end

      private

      def sort_hash(h)
        case Soya.json_type(h)
        when :hash
          {}.tap do |h2|
            h.sort.each do |k,v|
              h2[k] = sort_hash(v)
            end
          end
        when :array
          h.map { |v| sort_hash(v) }
        when :scalar
          h
        else
          raise Soya::Error.new("error: unknown JSON type: #{key}")
        end
      end
    end # Canonical
  end # Action
end # Soya
