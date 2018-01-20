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

require 'soya/action/extraction'

describe Soya::Action::Extraction do
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

  context 'extract everything' do
    it 'leaves the input hash unchanged' do
      expect(Soya::Action::Extraction.new('', hash).result).to eql(hash)
    end
  end

  context 'extract a subtree' do
    it 'return everything under a.b' do
      expect(Soya::Action::Extraction.new('a.b', hash).result).to eql({'c'=>1,'d'=>2})
    end
  end

  context 'extract a single hash element' do
    it 'return everything under a.b.c' do
      expect(Soya::Action::Extraction.new('a.b.c', hash).result).to eql(1)
    end
  end

  context 'extract a single array element' do
    it 'return everything under a.h.[2]' do
      expect(Soya::Action::Extraction.new('a.h.[2]', hash).result).to eql(7)
    end
  end

  context 'given an invalid key' do
    it "raises a Soya:Error exception" do
      expect { Soya::Action::Extraction.new('z', hash) }.to raise_error(Soya::Error)
    end
  end
end
