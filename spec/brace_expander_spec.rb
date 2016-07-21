require 'spec_helper'

describe BraceExpander do
  describe '#expand' do
    # shorthand
    def expand(str)
      BraceExpander.expand(str)
    end

    it 'expands stuff' do
      expect(expand('foo/{a,b,c}')).to eq(%w(foo/a foo/b foo/c))
    end

    it 'expands multiple things' do
      expect(expand('foo/{a,b,c}/{d,e}')).to match_array(%w(foo/a/d foo/b/d foo/c/d foo/a/e foo/b/e foo/c/e))
    end

    it 'does not expand escaped quoted commas' do
      expect(expand('{a,b,\\,}')).to eq(%w(a b ,))
    end

    it 'does not expand quoted braces' do
      expect(expand('{a,b,\\}}')).to eq(%w(a b }))
    end

    it 'expands the empty string into itself' do
      expect(expand('')).to eq([''])
    end

    it 'works with empty groups' do
      expect(expand('{}')).to eq([''])
      expect(expand('a{}')).to eq(['a'])
    end
  end
end
