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
require 'soya/path'

module Soya
  module Action
    class Insertion
      attr_reader :result

      def initialize(path, hash)
        value = Soya::deep_clone(hash)
        @result = Soya::Path.new(path).components.reverse_each.reduce(value) do |memo, key|
          { key => memo }
        end
      end
    end # Insertion
  end # Action
end # Soya
