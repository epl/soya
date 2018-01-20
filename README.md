# Soya

YAML/JSON file toolkit

## Introduction

Soya is a program designed to work with YAML and JSON files in a flexible manner that I hope will be useful for configuration
management.

## License

soya - YAML/JSON toolkit

Copyright (c) 2018 Edmund Lam

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the [GNU General Public License](LICENSE)
along with this program.  If not, see <http://www.gnu.org/licenses/>.

This application includes software licensed under the MIT License (see
`doc/MIT-LICENSE`) and `Copyright (c) 2015 REA-Group`.

## System Requirements

- Ruby 1.9.3 (or higher). See: <https://www.ruby-lang.org>
- Rubygem safe_yaml 1.0.4 (or higher). See: <https://github.com/dtao/safe_yaml>

## Installation

    $ gem install safe_yaml
    $ gem install soya
    $ soya -h

## History and Philosophy

I initially wanted to write a program that converted between YAML and JSON. That was due to my desire to use YAML as my
AWS-CloudFormation template language (due to YAML's support of comments and before AWS added YAML support), but I still wanted
to be able to easily use JSON templates from online search results.

Over time, the problem space expanded. I should possibly split this into multiple programs, that's the Unix-way after all. But
managing half-a-dozen scripts seems like it'd be a pain. And the various functionality seems to complement each other pretty well.

The background of the copying functionality was my desire to take advantage of anchors/references within the YAML specification.
But given the lack of JSON support, I made it a copy action instead. This is a pattern in this program. While it supports both
JSON and YAML, it fundamentally caters to the lowest-common-denominator (which is JSON) when deciding what's valid/invalid (eg
data-types). It's undoubtedly a sign that I should have one program that translates between JSON/YAML and a different one which
does everything else (with YAML only). But this current program solves my problem pretty well right now, though I accept chocolate
bribes.

YAML is a complex specification. And I'm pretty sure that there are bugs in more obscure uses of this program. That said, I suspect
I've covered 99% of the common use cases. And in the spirit of "Worse-is-Better" (see:
<https://www.dreamsongs.com/RiseOfWorseIsBetter.html>), I think I can leave those corner cases unresolved for now.
