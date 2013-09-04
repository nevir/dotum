shared_context "path fixtures" do

  let(:path_fixture_root) { File.join(FIXTURE_ROOT, "util", "path") }

  let(:file_fixture)      { File.join(path_fixture_root, "file") }
  let(:directory_fixture) { File.join(path_fixture_root, "directory") }
  let(:symlink_fixture)   { File.join(path_fixture_root, "symlink") }
  let(:non_fixture)       { File.join(path_fixture_root, "not_here") }

end
