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

require 'soya/expression'
require 'soya/action/insertion'

module Soya
  module Action
    class Definition
      attr_reader :result

      def initialize(definitions, hash)
        @result = definitions.reduce(hash) do |memo, definition|
          # Key names cannot have either '.' or '='. A plausible extension
          # would be to handle key names like: key_a."key.b".'key.c'.key-d
          (path, expression) = definition.split('=', 2)
          value = Soya::Expression.new(expression).value
          memo.merge(Soya::Action::Insertion.new(path, value).result, &Soya.method(:merge_strategy))
        end
      end
    end # Definition
  end # Action
end # Soya

