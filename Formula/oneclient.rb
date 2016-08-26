class Oneclient < Formula
  desc "Installs Oneclient, the Command Line tool for Onedata platform"
  homepage "https://onedata.org"
  url "ssh://git@git.plgrid.pl:7999/vfs/oneclient.git", :branch => "feature/osxfuse-port"
  version "3.0.0-RC3"
  #sha256 "85cc828a96735bdafcf29eb6291ca91bac846579bcef7308536e0c875d6c81d7"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libsodium"
  depends_on "go"
  depends_on "protobuf"
  depends_on "tbb"
  depends_on "ninja"
  #depends_on "osxfuse-beta"
  depends_on "aws-sdk-cpp"
  depends_on "bkryza/onedata/swift-cpp-sdk"

  def caveats
    <<-EOS.undent
      This package requires OSXFuse version >=3.4.2.

      Install manually from https://osxfuse.github.io/ or using

      brew install Caskroom/versions/osxfuse-beta
    EOS
  end 

  def install
    system 'cmake -G "Unix Makefiles"'
    system "make"
    system "make", "install"
  end
end