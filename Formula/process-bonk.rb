class ProcessBonk < Formula
  desc "BONK process, don't eat all my Mac's CPU"
  homepage ""
  url "https://github.com/snorremd/process-bonk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "6a6bedc6b2e0b17badd068cc99c720de7aaa5492a218ead7a750469345234f38"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  service do
    run [opt_bin/"process-bonk",  "#{etc}/process-bonk/process-bonk.toml"]
    log_path var/"log/process-bonk.log"
    error_log_path var/"log/process-bonk.log"
  end

  def post_install
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
    system "true"
  end
end
