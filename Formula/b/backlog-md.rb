class BacklogMd < Formula
  desc "Markdown‑native Task Manager & Kanban visualizer for any Git repository"
  homepage "https://github.com/MrLesk/Backlog.md"
  url "https://registry.npmjs.org/backlog.md/-/backlog.md-1.14.1.tgz"
  sha256 "866572a1fc49a0f55546048aeec4eb430f161d95618e592f3b5f2e7f434574e3"
  license "MIT"

  bottle do
    sha256                               arm64_tahoe:   "f80786138638d0dabd5741ed12ddb6c974b5c0b13bf16f03e02da23827d22c69"
    sha256                               arm64_sequoia: "f80786138638d0dabd5741ed12ddb6c974b5c0b13bf16f03e02da23827d22c69"
    sha256                               arm64_sonoma:  "f80786138638d0dabd5741ed12ddb6c974b5c0b13bf16f03e02da23827d22c69"
    sha256 cellar: :any_skip_relocation, sonoma:        "02ef268f3900868ff7ef0e1ecb59af6f3b58a828a72be7cd3173500aaae9c605"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "edce5ce9fba89b7a3eacefa8aa33bf3098b8961c1337e3221ea06adb06ece82c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bf428ba75e52d11589603e892553a8650e53530d0249b921424652fa263c176d"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/backlog --version")

    system "git", "init"
    system bin/"backlog", "init", "--defaults", "foobar"
    assert_path_exists testpath/"backlog"
  end
end
