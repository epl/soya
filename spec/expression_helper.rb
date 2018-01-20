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

RSpec::Matchers.define :be_a_match do
  match do |actual|
    actual.match? == true and actual.type == @expected_type and actual.value == @expected_value
  end

  chain :with_type do |type|
    @expected_type = type
  end

  chain :with_value do |value|
    @expected_value = value
  end
end

RSpec::Matchers.define :be_a_mismatch do
  match do |actual|
    actual.match? == false
  end
end
