class Libheif1 < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.5.1/libheif-1.5.1.tar.gz"
  sha256 "b134d0219dd2639cc13b8a8bcb8f264834593dd0417da1973fbe96e810918a8b"
  revision 1

  bottle :unneeded
  conflicts_with "libheif",
    :because => "homebrew-core version of the same formula"

  depends_on "pkg-config" => :build
  depends_on "libde265"
  depends_on "shared-mime-info"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-examples",
                          "--disable-go",
                          "--disable-gdk-pixbuf",
                          "--prefix=#{prefix}"
    system "make", "install-strip"
  end

  def post_install
    system Formula["shared-mime-info"].opt_bin/"update-mime-database", "#{HOMEBREW_PREFIX}/share/mime"
  end
end
