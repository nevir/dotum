describe Dotum::Context, '#fork' do

  subject do
    described_class.new(:target_dir => 'code/goes/heer')
  end

  it 'should not require any new attributes' do
    forked = subject.fork
    expect(forked).to_not be(subject)
    expect(forked.target_dir).to eq(subject.target_dir)
  end

  it 'should override attributes' do
    forked = subject.fork(:target_dir => 'nope', :state_dir => 'hmm')
    expect(forked.target_dir.basename).to eq('nope')
    expect(forked.state_dir.basename).to eq('hmm')
  end

end
