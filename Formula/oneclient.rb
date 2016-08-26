class Oneclient < Formula
  desc "Installs Oneclient, the Command Line tool for Onedata platform"
  homepage "onedata.org"
  url "ssh://git@git.plgrid.pl:7999/vfs/oneclient.git"
  #sha256 "85cc828a96735bdafcf29eb6291ca91bac846579bcef7308536e0c875d6c81d7"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libsodium"
  depends_on "go"
  depends_on "protobuf"
  depends_on "tbb"
  depends_on "ninja"
  depends_on "bkryza/homebrew-onedata/swift-cpp-sdk"

  def install
    system 'cmake -G "Unix Makefiles"'
    system "make"
    system "make", "install"
  end
end