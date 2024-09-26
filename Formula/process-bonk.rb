class ProcessBonk < Formula
  desc "BONK process, don't eat all my Mac's CPU"
  homepage "https://github.com/snorremd/process-bonk"
  url "https://github.com/snorremd/process-bonk/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0798f01a58dcca17d85da155938cbdf49caa6dd863cef51b27ae5265e78b56b2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/snorremd/tap"
    sha256 cellar: :any_skip_relocation, ventura:      "4de51d1bb281ca8c4efb90a30e8d0a0beb87b4f7865d617adb51ec36378100d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a389e08cf033361c60b39712ff3adef5ff5025b503ebc5bd5c15106abe3f27fa"
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
        stats_path = ""
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
      stats_path = "/tmp/my-process-stats.log"
    EOS
  end

  test do
    system "true"
  end
end
