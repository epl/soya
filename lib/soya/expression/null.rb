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
    class Null
      def initialize(expression)
        if expression == 'null'
          @match = true
        else
          @match = false
        end
      end

      def match?
        return @match
      end

      def value
        if @match
          return nil
        else
          raise Soya::Error.new("error: invalid nil value")
        end
      end

      def type
        return :null
      end
    end # Null
  end # Expression
end # Soya
