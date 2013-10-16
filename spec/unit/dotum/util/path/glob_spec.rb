describe Dotum::Util::Path, '#glob' do
  include_context 'path fixtures'

  subject { described_class.new(directory_fixture) }

  let(:one)      { subject.join('one') }
  let(:two)      { subject.join('two') }
  let(:three)    { subject.join('three') }
  let(:foo)      { subject.join('foo') }
  let(:hidden)   { subject.join('.hidden') }
  let(:sub)      { subject.join('sub') }
  let(:sub_four) { subject.join('sub', 'four') }
  let(:sub_five) { subject.join('sub', 'five') }
  let(:sub_six)  { subject.join('sub', 'six') }

  it 'should return an empty array for no matches' do
    expect(subject.glob('not/a/single/match')).to eq([])
  end

  it 'should support * globs' do
    expect(subject.glob('*')).to match_array([one, two, three, foo, hidden, sub])
  end

  it 'should support **/* globs' do
    expect(subject.glob('**/*')).to match_array([
      one, two, three, foo, hidden, sub, sub_four, sub_five, sub_six
    ])
  end

  it 'should support filtered ** globs' do
    expect(subject.glob('**/f*')).to match_array([foo, sub_four, sub_five])
  end

  it 'should support filtering by path' do
    expect(subject.glob('*', &:file?)).to match_array([one, two, three, foo, hidden])
  end

  it 'should return Paths' do
    expect(subject.glob('*').map(&:class).uniq).to eq([described_class])
  end

end
