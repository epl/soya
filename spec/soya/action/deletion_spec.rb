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

require 'soya/action/deletion'

describe Soya::Action::Deletion do
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

  context 'empty deletion' do
    it 'leaves the input hash unchanged' do
      expect(Soya::Action::Deletion.new([], hash).result).to eql(hash)
    end
  end

  context 'simple key deletion' do
    it 'return all other hash elements' do
      expect(Soya::Action::Deletion.new(['a.b.c'], hash).result).to eql({'a'=>{'b'=>{'d'=>2},'e'=>{'f'=>3,'g'=>4},'h'=>[5,6,7,8]}})
    end
  end

  context 'multiple key and array deletion' do
    it 'return all other elements' do
      expect(Soya::Action::Deletion.new(['a.e','a.b.d','a.h.[2]'], hash).result).to eql({'a'=>{'b'=>{'c'=>1},'h'=>[5,6,8]}})
    end
  end

  context 'given an invalid key' do
    it "raises a Soya:Error exception" do
      expect { Soya::Action::Deletion.new(['z'], hash) }.to raise_error(Soya::Error)
    end
  end
end
