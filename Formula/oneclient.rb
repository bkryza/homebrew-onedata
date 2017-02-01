class Oneclient < Formula
  desc "Installs Oneclient, the Command Line tool for Onedata platform"
  homepage "https://onedata.org"
  url "https://github.com/onedata/oneclient.git", :branch => "develop", :revision => "217d0cbb213b5aee4f1c8723d74c7395da8caaa4"
  version "3.0.0-rc11-76-g217d0cb"
  head "https://github.com/onedata/oneclient.git", :branch => "develop"

  depends_on :macos => :sierra

  depends_on :osxfuse
  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "boost"
  depends_on "boost-python" => [:build, "with-python3"]
  depends_on "go" => :build
  depends_on "libsodium"
  depends_on "protobuf"
  depends_on "tbb"
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

 # bottle do
 #   url ""
 #   sha256 "" => :sierra
 # end

  def install
    # Setup environment variables for the build
    ENV["PKG_CONFIG_PATH"]="#{HOMEBREW_PREFIX}/opt/nss/lib/pkgconfig"

    # Setup make arguments
    args = %w[
      release
      WITH_COVERAGE=OFF
      WITH_CEPH=OFF
      WITH_S3=OFF
      WITH_SWIFT=OFF
      WITH_OPENSSL=ON
      OPENSSL_ROOT_DIR=/usr/local/opt/openssl
      OPENSSL_LIBRARIES=/usr/local/opt/openssl/lib
      DESTDIR=@prefix.to_s
    ]

    # Make release version
    system "make", *args

    # Install all files into the default Cellar
    bin.install "release/oneclient"
    etc.install "config/oneclient.conf"
    man1.install "man/oneclient.1"
    man5.install "man/oneclient.conf.5"
    doc.install "LICENSE.txt"
    doc.install "README.md"
    bash_completion.install "autocomplete/osx/oneclient.bash-completion" => "oneclient"
    zsh_completion.install "autocomplete/osx/_oneclient"
  end

  def caveats
    <<-EOS.undent

      This is an experimental version of Onedata `oneclient` command line tool.

      To mount your Onedata spaces add the following mount options on the
      command line:

        oneclient -o allow_other,defer_permissions,fsname=oneclient,volname=Oneclient,kill_on_unmount,noappledouble,noapplexattr ...

      For more information on `oneclient` usage check:

        man oneclient

    EOS
  end

  test do
    system "#{bin}/oneclient --version | grep Oneclient"
  end
end
