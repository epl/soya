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
require 'soya/expression/boolean'

describe Soya::Expression::Boolean do
  context "given a string 'true'" do
    it "returns match" do
      expect(Soya::Expression::Boolean.new('true')).to be_a_match.with_type(:boolean).with_value(true)
    end
  end

  context "given a string 'false'" do
    it "returns match" do
      expect(Soya::Expression::Boolean.new('false')).to be_a_match.with_type(:boolean).with_value(false)
    end
  end

  mismatches = [ 'TRUE', 'FALSE', 'yes', 'no', '1', '0', '', nil ]
  mismatches.each do |input|
    context "given a string '#{input}'" do
      it "doesn't return a match" do
        expect(Soya::Expression::Boolean.new(input)).to be_a_mismatch
      end
    end
  end
end
