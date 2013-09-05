# encoding: utf-8

describe Dotum::Context, "#child" do

  subject {
    described_class.new(:target_dir => "code/goes/heer")
  }

  it "should not require any new attributes" do
    child = subject.child
    expect(child).to_not be(subject)
    expect(child.target_dir).to eq(subject.target_dir)
    expect(child.depth).to eq(1)
  end

  it "should override attributes" do
    child = subject.child(:target_dir => "nope", :state_dir => "hmm")
    expect(child.target_dir.basename).to eq("nope")
    expect(child.state_dir.basename).to eq("hmm")
    expect(child.depth).to eq(1)
  end

  it "should increase the depth" do
    child1 = subject.child
    child2 = child1.child
    expect(child1.depth).to eq(1)
    expect(child2.depth).to eq(2)
  end

  it "should override depth" do
    child = subject.child(:depth => 5)
    expect(child.depth).to eq(1)
  end

end
