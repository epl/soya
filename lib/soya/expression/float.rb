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

require 'soya/error'

module Soya
  class Expression
    class Float
      #MATCHER = /^[-+]?(?:\d+)?\.\d+(?:[eE][-+]\d+)?$/.freeze

      def initialize(expression)
        if /^-?\d+(\.\d+)?([eE][-+]?\d+)?$/.match(expression) && !/^-?0\d/.match(expression) && !/[eE][-+]?0\d+/.match(expression)
          @value = expression.to_f
        else
          @value = nil
        end
      end

      def match?
        return !@value.nil?
      end

      def value
        if @value.nil?
          raise Soya::Error.new("error: invalid float value")
        else
          return @value
        end
      end

      def type
        return :float
      end
    end # Float
  end # Expression
end # Soya
