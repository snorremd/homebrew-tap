class Rustic < Formula
  desc "Backup utility for encrypted deduplicated backups"
  homepage "https://rustic.cli.rs"
  url "https://github.com/rustic-rs/rustic/archive/refs/tags/v0.5.4.tar.gz"
  sha256 "af4f385696109d2df7247564cf4a9f58d776db6b8dab01a89261cbab31b823f9"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4e0f947da9989a4e8d6e57efc3c6eb076a83f3476aa6cd9b2f6071dac7b7d857"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "rustic 0.5.4\n", shell_output("#{bin}/rustic --version")
  end
end
