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
  module Action
    class Output
      attr_reader :result

      def initialize(format, hash)
        if format == :json
          if Hash === hash || Array === hash
            @result = JSON.pretty_generate(hash)
          else
            @result = hash
          end
        elsif format == :yaml || format == :yml
          @result = hash.to_yaml
        else
          ## The CLI parser should stop this from occurring.
          raise Soya::Error.new("impossible output format: #{format.to_s}")
        end
      end
    end # Output
  end # Action
end # Soya
