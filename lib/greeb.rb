# encoding: utf-8

require 'greeb/version'

# Greeb operates with entities, tuples of *(from, to, kind)*, where
# *from* is a beginning of the entity, *to* is an ending of the entity,
# and *kind* is a type of the entity.
#
# There are several entity types: `:letter`, `:float`, `:integer`,
# `:separ` for separators, `:punct` for punctuation characters,
# `:spunct` for in-sentence punctuation characters, and
# `:break` for line endings.
#
class Greeb::Entity < Struct.new(:from, :to, :type)
  # @private
  def <=> other
    if (comparison = self.from <=> other.from) == 0
      self.to <=> other.to
    else
      comparison
    end
  end
end

# This runtime error appears when {Greeb::Tokenizer} or
# {Greeb::Segmentator} tries to recognize unknown character.
#
class Greeb::UnknownEntity < RuntimeError
  attr_reader :text, :pos

  # @private
  def initialize(text, pos)
    @text, @pos = text, pos
  end

  # Generate the real error message.
  #
  def to_s
    'Could not recognize character "%s" @ %d' % [text[pos], pos]
  end
end

require 'greeb/strscan'
require 'greeb/tokenizer'
require 'greeb/segmentator'
require 'greeb/parser'
require 'greeb/core'
