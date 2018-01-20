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

require 'soya/action/output'

describe Soya::Action::Output do
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

  expected_json = <<-END.gsub(/^  /, '').rstrip
  {
    "a": {
      "b": {
        "c": 1,
        "d": 2
      },
      "e": {
        "f": 3,
        "g": 4
      },
      "h": [
        5,
        6,
        7,
        8
      ]
    }
  }
  END
  expected_yaml = <<-END.gsub(/^  /, '')
  ---
  a:
    b:
      c: 1
      d: 2
    e:
      f: 3
      g: 4
    h:
    - 5
    - 6
    - 7
    - 8
  END

  context 'JSON format' do
    it 'returns a string in JSON format' do
      expect(Soya::Action::Output.new(:json, hash).result).to eql(expected_json)
    end
  end

  context 'single element JSON format' do
    it 'returns an unquoted string' do
      expect(Soya::Action::Output.new(:json, "hello_world").result).to eql('hello_world')
    end
  end

  context 'YAML format' do
    it 'returns a string in YAML format' do
      expect(Soya::Action::Output.new(:yaml, hash).result).to eql(expected_yaml)
    end
  end

  context 'YML format' do
    it 'returns a string in YAML format' do
      expect(Soya::Action::Output.new(:yml, hash).result).to eql(expected_yaml)
    end
  end

  context 'Unknown format' do
    it 'throws an exception' do
      expect { Soya::Action::Output.new(:foo, hash) }.to raise_error(Soya::Error)
    end
  end

  context 'YML format' do
    it 'returns a string in YAML format' do
      expect(Soya::Action::Output.new(:yml, hash).result).to eql(expected_yaml)
    end
  end
end
