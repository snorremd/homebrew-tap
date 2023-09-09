class CloudSqlProxy < Formula
  desc "Utility for secure connections to your GCP SQL instances"
  homepage "https://github.com/GoogleCloudPlatform/cloud-sql-proxy"
  url "https://github.com/GoogleCloudPlatform/cloud-sql-proxy/archive/refs/tags/v2.6.1.tar.gz"
  sha256 "b5c4fd1decb2d4091f0ae118e2df8387cbee7ea166047be12c4183fbeecf0c46"
  license ""

  bottle do
    root_url "https://ghcr.io/v2/snorremd/tap"
    sha256 cellar: :any_skip_relocation, ventura:      "4e11326642437fd8038218c7e0550d8ad4a592517337fcda37343a811fea0dd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e0552218dc71d89765a640e056e945bae47fb585f2fd7c5901d494211df3dd3d"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "cloud-sql-proxy version 2.6.1\n", shell_output("#{bin}/cloud-sql-proxy --version")
  end
end
