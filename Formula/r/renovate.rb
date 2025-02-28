class Renovate < Formula
  desc "Automated dependency updates. Flexible so you don't need to be"
  homepage "https://github.com/renovatebot/renovate"
  url "https://registry.npmjs.org/renovate/-/renovate-39.183.0.tgz"
  sha256 "8c559c8ac9b30e6d34c31f7aac30d0500acd3c4d5430e3efa4a2d7389da0edcd"
  license "AGPL-3.0-only"

  # There are thousands of renovate releases on npm and the page the `Npm`
  # strategy checks is several MB in size and can time out before the request
  # resolves. This checks the first page of tags on GitHub (to minimize data
  # transfer).
  livecheck do
    url "https://github.com/renovatebot/renovate/tags"
    regex(%r{href=["']?[^"' >]*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
    strategy :page_match
    throttle 10
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e8298c45337c216dc064541914b42c5b199332cd6ffa0789a6713f6271d0e95"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a9169221731bb8f7e12a17d94d73384f5d93bc893c97e670fe5a5a59abbc75da"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "362c2e16747ecdc1c958857ae4aab7f74aad202b628233d9598618addd7992b9"
    sha256 cellar: :any_skip_relocation, sonoma:        "dcd757606000ee28d2316638762ac4957730a9791e77cfde83ccf51b81f6e62c"
    sha256 cellar: :any_skip_relocation, ventura:       "0803980276e4eafc4f32f82d8025885b63d7f8d806d1678ee86d5be721689703"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "33a32c125ce168d91ee84a4f9911c42ee53a00347741ff0ad834d91a18027172"
  end

  depends_on "node@22"

  uses_from_macos "git", since: :monterey

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"renovate", "--platform=local", "--enabled=false"
  end
end
