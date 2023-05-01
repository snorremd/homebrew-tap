class CloudSqlProxy < Formula
  desc "Utility for secure connections to your GCP SQL instances"
  homepage "https://github.com/GoogleCloudPlatform/cloud-sql-proxy"
  url "https://github.com/GoogleCloudPlatform/cloud-sql-proxy/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "83c3e801d9c153af47c74686e9d900e04adcbdb685328aad194bf91b55adc17c"
  license ""

  bottle do
    root_url "https://ghcr.io/v2/snorremd/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura: "c52805b068053dcc25a418f253dfd7530d1dc6d0245d1b6ae87bb31bcfcedc4e"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "cloud-sql-proxy version 2.2.0\n", shell_output("#{bin}/cloud-sql-proxy --version")
  end
end
