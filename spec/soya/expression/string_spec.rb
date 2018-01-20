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

require 'expression_helper'
require 'soya/expression/string'

describe Soya::Expression::String do
  matches = [
    { :input => 'abc', :value => 'abc' },
    { :input => '', :value => '' },
    { :input => ' ', :value => ' ' },
    { :input => ' abc ', :value => ' abc ' },
    { :input => '"abc"', :value => 'abc' },
    { :input => '""', :value => '' },
    { :input => '" "', :value => ' ' },
    { :input => '" abc "', :value => ' abc ' },
    { :input => "'abc'", :value => 'abc' },
    { :input => "''", :value => '' },
    { :input => "' '", :value => ' ' },
    { :input => "' abc '", :value => ' abc ' },
    { :input => 'null', :value => 'null' },
    { :input => 'true', :value => 'true' },
    { :input => 'false', :value => 'false' },
    { :input => '123', :value => '123' },
    { :input => '1.23', :value => '1.23' },
    { :input => nil, :value => nil }
  ]
  matches.each do |match|
    input = match[:input]
    value = match[:value]
    context "given a string '#{input}'" do
      it "return a match with #{value}" do
        expect(Soya::Expression::String.new(input)).to be_a_match.with_type(:string).with_value(value)
      end
    end
  end
end
