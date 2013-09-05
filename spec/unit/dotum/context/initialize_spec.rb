# encoding: utf-8

describe Dotum::Context, "#initialize" do

  it "should coerce paths" do
    context = described_class.new(
      :package_dir => "hi", :target_dir => "bye", :state_dir => "maybe"
    )

    expect(context.package_dir).to be_a(Dotum::Util::Path)
    expect(context.target_dir).to be_a(Dotum::Util::Path)
    expect(context.state_dir).to be_a(Dotum::Util::Path)
  end

  it "should support all attributes" do
    logger = Object.new

    context = described_class.new(
      :package_dir => Dotum::Util::Path.new("package"),
      :target_dir  => "target",
      :state_dir   => "state",
      :logger      => logger,
      :no_remote   => true,
      :depth       => 5
    )

    expect(context.package_dir).to eq(Dotum::Util::Path.new("package"))
    expect(context.target_dir).to  eq(Dotum::Util::Path.new("target"))
    expect(context.state_dir).to   eq(Dotum::Util::Path.new("state"))
    expect(context.logger).to      be(logger)
    expect(context.no_remote?).to  be_true
    expect(context.depth).to       eq(5)
  end

  it "should default depth to 0" do
    expect(described_class.new.depth).to eq(0)
  end

end
