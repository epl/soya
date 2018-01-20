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

module Soya
  class Expression
    class String
      def initialize(expression)
        if (match = /^\"(?<s>.*)\"$/.match(expression))
          @value = match[:s]
        elsif (match = /^\'(?<s>.*)\'$/.match(expression))
          @value = match[:s]
        else
          @value = expression
        end
      end

      def match?
        true
      end

      def value
        return @value
      end

      def type
        return :string
      end
    end # String
  end # Expression
end # Soya
