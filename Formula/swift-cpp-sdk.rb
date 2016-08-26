class SwiftCPPSDK < Formula
  desc "Openstack Swift C++ client ported to OSX"
  homepage "onedata.org"
  url "https://github.com/bkryza/Swift_CPP_SDK.git", :branch => "feature/osx-port"
  #sha256 "85cc828a96735bdafcf29eb6291ca91bac846579bcef7308536e0c875d6c81d7"

  # depends_on "cmake" => :build
  # depends_on "boost"
  # depends_on "libsodium"
  # depends_on "go"
  # depends_on "protobuf"
  # depends_on "tbb"
  # depends_on "ninja"
  # depends_on "bkryza/homebrew-onedata/AWS_SDK_CPP"

  def install
    system "make"
    system "make", "install"
  end
end