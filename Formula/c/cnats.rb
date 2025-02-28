class Cnats < Formula
  desc "C client for the NATS messaging system"
  homepage "https://github.com/nats-io/nats.c"
  url "https://github.com/nats-io/nats.c/archive/refs/tags/v3.9.3.tar.gz"
  sha256 "b5dd3971b72fa5fc4c5b6d71c6900dc0a8a20465824fc23c0054f7f319e97952"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "2a78ef2ec9c051aa59ad5fb619b9c6a74f87a7d4f0a1cbf159b41079fa0b0b6b"
    sha256 cellar: :any,                 arm64_sonoma:  "babb35e56f35059e0b44af5964fc351342a542146afbb8b1f32935165a751385"
    sha256 cellar: :any,                 arm64_ventura: "6a442ed8bf4e6ccb739014c367b4c279be789f2b2c578af54b332a1df15bddbf"
    sha256 cellar: :any,                 sonoma:        "b75bb0c7f53d3c34f03e9e55cabf18dfbb3c91e6c8da49f18b99af3ae6610117"
    sha256 cellar: :any,                 ventura:       "c3e4e47dfea6345ebbb52bdf7c72c3063e2628f7e2851607ca70a3692e053922"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a3329f5e43fdef0e55a5f871babcd45f89b0e95e472b9e3162f520308229afc0"
  end

  depends_on "cmake" => :build
  depends_on "libevent"
  depends_on "libuv"
  depends_on "openssl@3"
  depends_on "protobuf-c"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <nats/nats.h>
      #include <stdio.h>
      int main() {
        printf("%s\\n", nats_GetVersion());
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lnats", "-o", "test"
    assert_equal version, shell_output("./test").strip
  end
end
