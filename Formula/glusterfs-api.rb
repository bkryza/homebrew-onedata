class GlusterfsApi < Formula
  desc "Glusterfs API OSX port"
  homepage "http://gluster.org"
  url "https://github.com/gluster/glusterfs/archive/v3.11.1.tar.gz"
  sha256 "929da99014c6461dac268a43db4539b623909b67088ab16a640b631965cfcb16"

  conflicts_with "e2fsprogs", :because => "e2fsprogs provides incompatible uuid library"
  depends_on "openssl"
  depends_on "userspace-rcu"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  bottle do
    root_url "https://bintray.com/bkryza/onedata-cellar/download_file?file_path="
    rebuild 1
    sha256 "1c7e90e4ac7f3faa4e7a97ccb69559df24d925fefa25c1b541b626ed67a27fd8" => :sierra
  end

  patch do
    url "https://gist.githubusercontent.com/bkryza/3536da563b730df316a394a8b05d92cd/raw/4cfaaa367be78f800ed7de582bbdf3b7c8cfd5ff/glusterfs-3.11.0-event_dispatch_prfx.diff"
    sha256 "729c3444a1931c9df70652e9f5ad0c136afe0cbfc017e39b20335ea5536845ca"
  end

  patch do
    url "https://gist.githubusercontent.com/bkryza/bd6d9fd9bdda533ca244f0859efc610d/raw/cb363e484d8ed8b4a3dcbba354bde37c4d642c18/glusterfs-3.11.1-osx-port.diff"
    sha256 "12346ed8c264a33556cf87ea1a2b3daf6ee7906b43e3fd8634a9e789437ba851"
  end

  patch do
    url "https://gist.githubusercontent.com/bkryza/a1d5af2b7b4541e879336cb70c7cf561/raw/84be0f163424da849dab242707a5635cb358b8d3/glusterfs-3.11.1-remove-priv-namespace.dif://gist.githubusercontent.com/bkryza/a1d5af2b7b4541e879336cb70c7cf561/raw/84be0f163424da849dab242707a5635cb358b8d3/glusterfs-3.11.1-remove-priv-namespace.diff"
    sha256 "c51c19207dbdfdd4645d9a5009883eb7f43d53ee5bb852572e6c246d9cbfe964"
  end

  patch do
    url "https://gist.githubusercontent.com/bkryza/7bd46e2f33985b1b5dd27652025f9852/raw/12b352dcb4a0c045e234a2ea8da6c510fe32efaa/glusterfs-3.11.0-updated-locking.diff"
    sha256 "f61b33d7d4f6dfbd125f5c2943083615d5738bcdbecf84c97e1fa444f73534ae"
  end

  def install
    ENV["CFLAGS"]="-DLOGIN_NAME_MAX -O3 -DRELAX_POISONING -DGF_XATTR_NAME_MAX=255 -DGF_DARWIN_HOST_OS"
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-fusermount",
                          "--disable-fuse-client",
                          "--enable-valgrind",
                          "--enable-static",
                          "--libexecdir=#{bin}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
#include <cstring>
#include <errno.h>
#include <glusterfs/api/glfs-handles.h>
#include <glusterfs/api/glfs.h>
#include <iostream>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(int argc, char *argv[])
{
    struct stat sb;
    int ret = -1;

    glfs_t *fs = glfs_new(argv[1]);

    ret = glfs_set_volfile_server(fs, "tcp", "example.com", 24007);

    if (ret != 0) {
        std::cout << "Failed to configure volume: (" << ret << ") "
                  << strerror(errno) << "\n";
        return 1;
    }

    return 0;
}
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-lgfapi", "-lglusterfs", "-lgfrpc", "-lgfxdr", "-o", "test"
    system "./test"
  end
end
