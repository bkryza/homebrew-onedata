class Oneclient < Formula
  desc "Installs Oneclient, the Command Line tool for Onedata platform"
  homepage "https://onedata.org"
  url "https://github.com/onedata/oneclient.git", :branch => "develop-osx"
  version "3.0.0-RC12"
  #sha256 "85cc828a96735bdafcf29eb6291ca91bac846579bcef7308536e0c875d6c81d7"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libsodium"
  depends_on "go"
  depends_on "protobuf"
  depends_on "tbb"
  depends_on "ninja" => :build
  depends_on "poco"
  depends_on "osxfuse"
  depends_on "aws-sdk-cpp"
  depends_on "double-conversion"
  depends_on "glog"
  depends_on "folly"
  depends_on "nss"
  depends_on "openssl"
  depends_on "libevent"
  depends_on "nspr"
  depends_on "bkryza/onedata/swift-cpp-sdk"
  depends_on "bkryza/onedata/libiberty"

  def caveats
    <<-EOS.undent
      This package requires OSXFuse version >=3.5.4.

      Install manually from https://osxfuse.github.io/ or using

      brew install Caskroom/versions/osxfuse
    EOS
  end 

  def install
    system "make", "release", "WITH_COVERAGE=OFF", "WITH_CEPH=OFF", "WITH_S3=OFF", "WITH_SWIFT=OFF", "WITH_OPENSSL=OFF", "OPENSSL_ROOT_DIR=/usr/local/opt/openssl", "OPENSSL_LIBRARIES=/usr/local/opt/openssl/lib"
    system "DESTDIR=#{prefix}", "make", "install"
  end
end