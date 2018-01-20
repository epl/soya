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

require 'soya/action/insertion'

describe Soya::Action::Insertion do
  hash = {
    'a' => {
      'b' => {
        'c' => 1,
        'd' => 2
      },
      'e' => {
        'f' => 3,
        'g' => 4
      },
      'h' => [5,6,7,8]
    }
  }

  context 'insert an empty prefix' do
    it 'leaves the input hash unchanged' do
      expect(Soya::Action::Insertion.new('', hash).result).to eql(hash)
    end
  end

  context 'insert a subtree' do
    it 'return everything underneath x.y' do
      expect(Soya::Action::Insertion.new('x.y', hash).result).to eql({'x'=>{'y'=>hash}})
    end
  end
end
