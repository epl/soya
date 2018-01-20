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

require 'soya/action/copying'

describe Soya::Action::Copying do
  hash = {
    'a' => {
      'b' =>  {
        'c' => 1,
        'd' => 2
      },
      'e' => {
        'f' => 3,
        'g' => 4
      }
    }
  }

  context 'no copying' do
    it 'leaves the input unchanged' do
      expect(Soya::Action::Copying.new([], hash).result).to eql(hash)
    end
  end

  context 'a single element copy' do
    it 'new key is added' do
      expected = deep_clone(hash)
      expected['h'] = 1
      expect(Soya::Action::Copying.new(['h=a.b.c'], hash).result).to eql(expected)
    end
  end

  context 'multiple, subtree copies' do
    it 'multiple new keys are added' do
      expected = deep_clone(hash)
      expected['h'] = 1
      expected['i'] = {}
      expected['i']['j'] = { 'f'=>3, 'g'=>4}
      expected['a']['b']['x'] = 3
      expect(Soya::Action::Copying.new(['h=a.b.c','i.j=a.e','a.b.x=a.e.f'], hash).result).to eql(expected)
    end
  end
end

def deep_clone(obj)
  ## This breaks YAML anchors/references.
  Marshal.load(Marshal.dump(obj))
end
