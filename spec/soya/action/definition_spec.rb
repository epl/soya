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

require 'soya/action/definition'

describe Soya::Action::Definition do
  context 'empty definition' do
    it 'leaves the input hash unchanged' do
      hash = double('hash')
      expect(Soya::Action::Definition.new([], hash).result).to eql(hash)
    end
  end

  context 'simple key definition' do
    it 'return a single-element hash' do
      expect(Soya::Action::Definition.new(['a=1'], {}).result).to eql({'a'=>1})
    end
  end

  context 'multiple definitions, some in subtrees and a variety of expression types' do
    it 'return a complex hash' do
      expected = {
        'a' => 1,
        'b' => true,
        'c' => false,
        'd' => {
            'a' => nil,
            'b' => 3.1415926535,
        },
        'e' => 'hello',
        'f' => 'world',
      }
      input = ['a=1','b=true','c=false','d.a=null','d.b=0.31415926535e1','e="hello"','f=world']
      expect(Soya::Action::Definition.new(input, {'a'=>0}).result).to eql(expected)
    end
  end
end
