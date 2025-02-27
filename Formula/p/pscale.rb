class Pscale < Formula
  desc "CLI for PlanetScale Database"
  homepage "https://www.planetscale.com/"
  url "https://github.com/planetscale/cli/archive/refs/tags/v0.224.0.tar.gz"
  sha256 "6ed9cf3db6439eb0cf45d4fe553262e63f1d17e17aec6dc3447b673ad8f83ff6"
  license "Apache-2.0"
  head "https://github.com/planetscale/cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5e007f52b7a971aef79cdb8bb2d3ee727f4bb1a77bf64d900df5874cd1af67fe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c625673da095490f1bf365e8eb73232bc76a987c4469e04ad627993cd76c84d3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a4b7d6dc7467a50751a0444f6d6755ed5cb75680665b02855c0680f7dc3710c2"
    sha256 cellar: :any_skip_relocation, sonoma:        "6744dda02e873b1574547f45e89635fac08169701dc02da093a43b594361c75f"
    sha256 cellar: :any_skip_relocation, ventura:       "44008dea8e09d378102a12487f1d4cfc23a10ef925f35a157a05ce88e3be4940"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e262db7d150846647b024846b94f5922edb3048cbf74c5d5dd8ea456043ce0d0"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version} -X main.commit=#{tap.user} -X main.date=#{time.iso8601}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/pscale"

    generate_completions_from_executable(bin/"pscale", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pscale version")

    assert_match "Error: not authenticated yet", shell_output("#{bin}/pscale org list 2>&1", 2)
  end
end
