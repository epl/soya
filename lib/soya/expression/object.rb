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

require 'json'
require 'soya/error'

module Soya
  class Expression
    class Object
      def initialize(expression)
        if /^\{.*\}$/.match(expression)
          begin
            @value = JSON.parse(expression)
          rescue JSON::ParserError => e
            message = 'definition parse-error: ' + e.message
            raise Soya::Error.new(message)
          end
        else
          @value = nil
        end
      end

      def match?
        return !@value.nil?
      end

      def value
        if @value.nil?
          raise Soya::Error.new("error: invalid object value")
        else
          return @value
        end
      end

      def type
        return :object
      end
    end # Object
  end # Expression
end # Soya
