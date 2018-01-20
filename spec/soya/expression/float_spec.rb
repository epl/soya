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
require 'soya/expression/float'

describe Soya::Expression::Float do
  matches = [
    { :input => '0', :value => 0.0 },
    { :input => '-0', :value => 0.0 },
    { :input => '-1', :value => -1.0 },
    { :input => '1', :value => 1.0 },
    { :input => '-9223372036854775807', :value => -9.223372036854775807e18 },
    { :input => '9223372036854775807', :value => 9.223372036854775807e18 },
    { :input => '1.23', :value => 1.23 },
    { :input => '-1.23', :value => -1.23 },
    { :input => '0.03145', :value => 0.03145 },
    { :input => '0.012345678e7', :value => 123456.78 },
    { :input => '0.012345678e+7', :value => 123456.78 },
    { :input => '-12345678E-7', :value => -1.2345678 },
  ]
  matches.each do |match|
    input = match[:input]
    value = match[:value]
    context "given a string '#{input}'" do
      it "return a match with #{value}" do
        expect(Soya::Expression::Float.new(input)).to be_a_match.with_type(:float).with_value(value)
      end
    end
  end

  mismatches = [ 'hello_world', '123abc', ' 123 ', '012', '', nil ]
  mismatches.each do |input|
    context "given a string '#{input}'" do
      it "doesn't return a match" do
        expect(Soya::Expression::Float.new(input)).to be_a_mismatch
      end
    end
  end
end
