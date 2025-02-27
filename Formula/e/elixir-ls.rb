class ElixirLs < Formula
  desc "Language Server and Debugger for Elixir"
  homepage "https://elixir-lsp.github.io/elixir-ls"
  url "https://github.com/elixir-lsp/elixir-ls/archive/refs/tags/v0.27.0.tar.gz"
  sha256 "b03c007b3777d125736c308e9363d75c0ab4f153b1f76cb2d193510daab14c14"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "3771f756ad6e0ea8a03a88af1186ee651597b901f79f7ea86de776b64488382b"
  end

  depends_on "elixir"

  def install
    ENV["MIX_ENV"] = "prod"

    system "mix", "local.hex", "--force"
    system "mix", "local.rebar", "--force"
    system "mix", "deps.get"
    system "mix", "compile"
    system "mix", "elixir_ls.release2", "-o", libexec
    libexec.glob("*.bat").map(&:unlink)

    bin.install_symlink libexec/"language_server.sh" => "elixir-ls"
  end

  test do
    assert_path_exists bin/"elixir-ls"
    system "mix", "local.hex", "--force"

    input =
      "Content-Length: 152\r\n" \
      "\r\n" \
      "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"initialize\",\"params\":{\"" \
      "processId\":88075,\"rootUri\":null,\"capabilities\":{},\"trace\":\"ver" \
      "bose\",\"workspaceFolders\":null}}\r\n"

    output = pipe_output(bin/"elixir-ls", input, 0)
    assert_match "Content-Length", output
  end
end
