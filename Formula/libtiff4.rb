class Libtiff4 < Formula
  desc "TIFF library and utilities"
  homepage "http://libtiff.maptools.org/"
  url "https://download.osgeo.org/libtiff/tiff-4.0.10.tar.gz"
  mirror "https://fossies.org/linux/misc/tiff-4.0.10.tar.gz"
  sha256 "2c52d11ccaf767457db0c46795d9c7d1a8d8f76f68b0b800a3dfe45786b996e4"

  bottle :unneeded

  conflicts_with "libtiff",
    :because => "homebrew-core version of the same formula"

  depends_on "jpeg-turbo"

  # Patches are taken from latest Fedora package, which is currently
  # libtiff-4.0.10-2.fc30.src.rpm and whose changelog is available at
  # https://apps.fedoraproject.org/packages/libtiff/changelog/

  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/d15e00544e7df009b5ad34f3b65351fc249092c0/libtiff/libtiff-CVE-2019-6128.patch"
    sha256 "dbec51f5bec722905288871e3d8aa3c41059a1ba322c1ac42ddc8d62646abc66"
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-lzma
      --disable-mdi
      --disable-pixarlog
      --disable-cxx
      --with-jpeg-include-dir=#{Formula["jpeg-turbo"].opt_include}
      --with-jpeg-lib-dir=#{Formula["jpeg-turbo"].opt_lib}
      --without-x
    ]
    system "./configure", *args
    system "make", "install"
  end
end
