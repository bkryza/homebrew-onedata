class Oneclient < Formula
  desc "Installs Oneclient, the Command Line tool for Onedata platform"
  homepage "https://onedata.org"
  url "https://github.com/onedata/oneclient.git", :branch => "develop", :revision => "217d0cbb213b5aee4f1c8723d74c7395da8caaa4"
  version "3.0.0-rc11-217d0cb"

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
  depends_on "bkryza/onedata/swift-cpp-sdk" => :optional
  depends_on "onedata/onedata/libiberty"

  # devel do
  #   url "https://github.com/onedata/oneclient.git", :branch => "develop"
  # end

 # bottle do
 #   url ""
 #   sha256 "47ae0e479cdb15bea6820f7f2d659d45e9d7a09a97a2d7f44c02b6c7a689dd9f" => :sierra
 # end

  def install
    # Setup environment variables for the build
    ENV["PKG_CONFIG_PATH"]="/usr/local/opt/nss/lib/pkgconfig"
    ENV["DESTDIR"]=@prefix.to_s

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
    ]

    # Make release version
    system "make", *args

    # Install all files into the default Cellar
    system "make", "install"

    # Setup autocompletion scripts
    bash_completion.install "var/lib/oneclient/oneclient.bash-completion" => "oneclient"
    zsh_completion.install "var/lib/oneclient/_oneclient"
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
