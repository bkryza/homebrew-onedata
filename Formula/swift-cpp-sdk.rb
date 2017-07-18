class SwiftCppSdk < Formula
  desc "Openstack Swift C++ client ported to OSX"
  homepage "onedata.org"
  url "https://github.com/onedata/Swift_CPP_SDK.git", :branch => "feature/osx-port"

  depends_on "poco"

  def install
    system "make"
    system "make", "install", "DESTDIR=#{prefix}"
  end
end
