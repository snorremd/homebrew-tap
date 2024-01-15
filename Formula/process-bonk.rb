# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class ProcessBonk < Formula
  desc "BONK process, don't eat all my Mac's CPU"
  homepage ""
  url "https://github.com/snorremd/process-bonk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "6a6bedc6b2e0b17badd068cc99c720de7aaa5492a218ead7a750469345234f38"
  license "MIT"

  depends_on "rust" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cargo", "install", *std_cargo_args
  end

  service do
    # Run with config file in /opt/homebrew/etc/process-bonk.toml
    run [opt_bin/"process-bonk",  "#{etc}/process-bonk/process-bonk.toml"]
    log_path var/"log/process-bonk.log"
    error_log_path var/"log/process-bonk.log"
  end

  def post_install
    # Install the config file
    pkgetc.install "process-bonk.toml"
  end

  def caveats
    <<~EOS
      The config file is located at:
      #{pkgetc}/process-bonk.toml
      
      Please edit this file to suit your needs.
      E.g. to monitor a process with name "my-process"
      specify the following in the config file:
      process_name = "my-process"
    EOS
  end


  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test process-bonk`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
