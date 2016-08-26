class SwiftCppSdk < Formula
  desc "Openstack Swift C++ client ported to OSX"
  homepage "onedata.org"
  url "https://github.com/bkryza/Swift_CPP_SDK.git", :branch => "feature/osx-port"

  def install
    system "make"
    system "make", "install"
  end
end