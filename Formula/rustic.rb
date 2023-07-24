class Rustic < Formula
  desc "Backup utility for encrypted deduplicated backups"
  homepage "https://rustic.cli.rs"
  url "https://github.com/rustic-rs/rustic/archive/refs/tags/v0.5.4.tar.gz"
  sha256 "af4f385696109d2df7247564cf4a9f58d776db6b8dab01a89261cbab31b823f9"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/snorremd/tap"
    sha256 cellar: :any_skip_relocation, ventura:      "ba642c83b2e733b177ed6743dc49ee77b8f1d7091ba71e7e1fe4245ea52b4beb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "39115fde0803baf06a3719f973f620fe83a7d80fbba1279742f0d86103b252f0"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "rustic 0.5.4\n", shell_output("#{bin}/rustic --version")
  end
end
