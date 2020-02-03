class Libtiff4 < Formula
  desc "TIFF library and utilities"
  homepage "http://libtiff.maptools.org/"
  url "https://download.osgeo.org/libtiff/tiff-4.1.0.tar.gz"
  mirror "https://fossies.org/linux/misc/tiff-4.1.0.tar.gz"
  sha256 "5d29f32517dadb6dbcd1255ea5bbc93a2b54b94fbf83653b4d65c7d6775b8634"

  bottle :unneeded

  conflicts_with "libtiff",
    :because => "homebrew-core version of the same formula"

  depends_on "jpeg-turbo"

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
