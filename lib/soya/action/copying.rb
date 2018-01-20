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

require 'soya/action/extraction'
require 'soya/action/insertion'

module Soya
  module Action
    class Copying
      attr_reader :result

      def initialize(paths, hash)
        paths.each do |e|
          (destination, source) = e.split('=', 2)
          ## Without deep_cloning (see inside Soya::Action::Insertion) -- Ruby will create anchors/references for YAML output.
          subtree = Soya::Action::Insertion.new(destination,
                      Soya::Action::Extraction.new(source, hash).result
                    ).result
          hash = hash.merge(subtree, &Soya.method(:merge_strategy))
        end
        @result = hash
      end
    end # Copying
  end # Action
end # Soya
