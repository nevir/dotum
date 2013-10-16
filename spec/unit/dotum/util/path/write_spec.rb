require 'tempfile'

describe Dotum::Util::Path, '#write' do
  include_context 'path fixtures'

  let(:tempfile) { Tempfile.new('writer') }

  subject do
    described_class.new(tempfile.path)
  end

  it 'should write to a file' do
    subject.write('ohai')
    expect(subject.read).to eq('ohai')
  end

  it 'should not append to a file' do
    subject.write('one')
    subject.write('two')
    expect(subject.read).to eq('two')
  end

end
