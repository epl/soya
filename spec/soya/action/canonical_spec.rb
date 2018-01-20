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
require 'soya/action/canonical'

describe Soya::Action::Canonical do
  hash = {
    :z => 4,
    :m => {
      :o => 3,
      :n => 2
    },
    :a => 1
  }

  context 'when the conditional is true' do
    it 'the hash is recursively sorted by key' do
      expect(Soya::Action::Canonical.new(true, hash).result.to_s).to eql('{:a=>1, :m=>{:n=>2, :o=>3}, :z=>4}')
    end

  end

  context 'when the conditional is true' do
    it 'the hash order is left unchanged' do
      expect(Soya::Action::Canonical.new(false, hash).result.to_s).to eql('{:z=>4, :m=>{:o=>3, :n=>2}, :a=>1}')
    end
  end
end
