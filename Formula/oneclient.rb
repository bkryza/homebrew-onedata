class Oneclient < Formula
  desc "Installs Oneclient, the Command Line tool for Onedata platform"
  homepage "onedata.org"
  #url "https://example.com/foo-0.1.tar.gz"
  #sha256 "85cc828a96735bdafcf29eb6291ca91bac846579bcef7308536e0c875d6c81d7"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libsodium"
  depends_on "go"
  depends_on "protobuf"
  depends_on "tbb"
  depends_on "ninja"
  depends_on "bkryza/homebrew-onedata/AWS_SDK_CPP"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    # system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end