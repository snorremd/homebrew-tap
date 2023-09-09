class CloudSqlProxy < Formula
  desc "Utility for secure connections to your GCP SQL instances"
  homepage "https://github.com/GoogleCloudPlatform/cloud-sql-proxy"
  url "https://github.com/GoogleCloudPlatform/cloud-sql-proxy/archive/refs/tags/v2.6.1.tar.gz"
  sha256 "b5c4fd1decb2d4091f0ae118e2df8387cbee7ea166047be12c4183fbeecf0c46"
  license ""

  bottle do
    root_url "https://ghcr.io/v2/snorremd/tap"
    sha256 cellar: :any_skip_relocation, ventura:      "fa1d37ebaa79ed635caf621df3a5b5045b8126f489ad431463b2981d0c96fa9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4b22cde04b6847a54529f831adb4029bde52b4c098189d44ef724be6b04e4d29"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "cloud-sql-proxy version 2.6.1\n", shell_output("#{bin}/cloud-sql-proxy --version")
  end
end
