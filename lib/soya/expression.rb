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

require 'soya/expression/array'
require 'soya/expression/boolean'
require 'soya/expression/float'
require 'soya/expression/integer'
require 'soya/expression/null'
require 'soya/expression/object'
require 'soya/expression/string'

module Soya
  class Expression

    def initialize(expression_string)
      @expression = parse_expression(expression_string)
      Soya::verbose("  #{@expression.type.to_s.capitalize}: #{expression_string}")
    end

    def value
      @expression.value
    end

    def type
      @expression.type
    end

    private

    def parse_expression(string)
      [
        Soya::Expression::Null,
        Soya::Expression::Boolean,
        Soya::Expression::Integer,
        Soya::Expression::Float,
        Soya::Expression::Array,
        Soya::Expression::Object,
        ## Soya::Expression::String should always be last as it always matches.
        Soya::Expression::String
      ].each do |classz|
        expression = classz.new(string)
        if expression.match?
          return expression
        end
      end
    end

  end
end
