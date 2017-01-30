class Oneclient < Formula
  desc "Installs Oneclient, the Command Line tool for Onedata platform"
  homepage "https://onedata.org"
  url "https://github.com/onedata/oneclient.git", :branch => "develop-osx"
  version "3.0.0-RC12"

  depends_on :osxfuse
  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libsodium"
  depends_on "go"
  depends_on "protobuf"
  depends_on "tbb"
  depends_on "ninja" => :build
  depends_on "poco"
  depends_on "double-conversion"
  depends_on "glog"
  depends_on "folly"
  depends_on "nss"
  depends_on "openssl"
  depends_on "libevent"
  depends_on "nspr"
  depends_on "aws-sdk-cpp" => :optional
  depends_on "onedata/onedata/swift-cpp-sdk" => :optional
  depends_on "onedata/onedata/libiberty"

  def install
    ENV["PKG_CONFIG_PATH"]="/usr/local/opt/nss/lib/pkgconfig"
    ENV["DESTDIR"]=@prefix.to_s
    system "make", "release", "WITH_COVERAGE=OFF", "WITH_CEPH=OFF", \
           "WITH_S3=OFF ", "WITH_SWIFT=OFF", "WITH_OPENSSL=ON", \
           "OPENSSL_ROOT_DIR=/usr/local/opt/openssl", \
           "OPENSSL_LIBRARIES=/usr/local/opt/openssl/lib"
    system "make", "install"
  end

  def caveats
    <<-EOS.undent
      This package requires OSXFuse version >= 3.5.4.

      Install manually from https://osxfuse.github.io/ or using

      brew cask install osxfuse
    EOS
  end

  test do
    system "#{bin}/oneclient --version | grep Oneclient"
  end
end
