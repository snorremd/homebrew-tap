class ProcessBonk < Formula
  desc "BONK process, don't eat all my Mac's CPU"
  homepage "https://github.com/snorremd/process-bonk"
  url "https://github.com/snorremd/process-bonk/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "048356323c67a99c21b6aad0fe37c547b16953213c067020f6de7c524e2add60"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/snorremd/tap"
    sha256 cellar: :any_skip_relocation, ventura:      "907b82f4dbae39a595fb75fe197a0792cce270329d9b97d0fb0c8280ebbe4f26"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fd68dccc7bdc3aa415c5513784acd27f8dea524afe58ffafc0a57f70b45091f4"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  service do
    run [opt_bin/"process-bonk", "#{etc}/process-bonk/process-bonk.toml"]
    log_path var/"log/process-bonk.log"
    error_log_path var/"log/process-bonk.log"
  end

  def post_install
    # Create a configuration file if it doesn't exist
    (etc/"process-bonk").mkpath
    unless (etc/"process-bonk/process-bonk.toml").exist?
      (etc/"process-bonk/process-bonk.toml").write <<~EOS
        process_name = ""
      EOS
    end
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
    system "true"
  end
end
