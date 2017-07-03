class GlusterfsApi < Formula
  desc "Glusterfs API OSX port"
  homepage "http://gluster.org"
  #url "https://github.com/gluster/glusterfs.git", :tag => "v3.11.1"
  url "https://github.com/gluster/glusterfs/archive/v3.11.1.tar.gz"
  sha256 "929da99014c6461dac268a43db4539b623909b67088ab16a640b631965cfcb16"

  depends_on "e2fsprogs"
  depends_on "openssl"
  depends_on "userspace-rcu"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  bottle do
    url "https://bintray.com/bkryza/onedata-cellar/download_file?file_path=glusterfs-api-3.11.1.sierra.bottle.tar.gz"
    sha256 "33931b20638cdc350a31e517d3471699cd9fc3b7182486fd6bfacf6ed946f7e7" => :sierra
  end

  patch do
    url "https://gist.githubusercontent.com/bkryza/3536da563b730df316a394a8b05d92cd/raw/4cfaaa367be78f800ed7de582bbdf3b7c8cfd5ff/glusterfs-3.11.0-event_dispatch_prfx.diff"
    sha256 "729c3444a1931c9df70652e9f5ad0c136afe0cbfc017e39b20335ea5536845ca"
  end

  patch do
    url "https://gist.githubusercontent.com/bkryza/bd6d9fd9bdda533ca244f0859efc610d/raw/cb363e484d8ed8b4a3dcbba354bde37c4d642c18/glusterfs-3.11.1-osx-port.diff"
    sha256 "12346ed8c264a33556cf87ea1a2b3daf6ee7906b43e3fd8634a9e789437ba851"
  end

  def install
    ENV["CFLAGS"]="-DLOGIN_NAME_MAX -O3 -DRELAX_POISONING -DGF_XATTR_NAME_MAX=255 -DGF_DARWIN_HOST_OS"
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-fusermount",
                          "--disable-fuse-client",
                          "--libexecdir=#{bin}"
    system "make"
    system "make", "install"
  end
end
