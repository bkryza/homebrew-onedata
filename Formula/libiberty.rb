class Libiberty < Formula
  desc "Libiberty from binutils"
  homepage "https://www.gnu.org/software/binutils/"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.gz"
  md5 "41b053ed4fb2c6a8173ef421460fbb28"

  def install
    system "cd", "libiberty"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end