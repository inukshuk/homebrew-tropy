class Webp1 < Formula
  desc "Image format providing lossless and lossy compression for web images"
  homepage "https://developers.google.com/speed/webp/"
  url "https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.0.3.tar.gz"
  sha256 "e20a07865c8697bba00aebccc6f54912d6bc333bb4d604e6b07491c1a226b34f"

  bottle :unneeded
  conflicts_with "webp",
    :because => "homebrew-core version of the same formula"

  head do
    url "https://chromium.googlesource.com/webm/libwebp.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-gif",
                          "--disable-gl",
                          "--disable-jpeg",
                          "--disable-tiff",
                          "--disable-png",
                          "--disable-wic",
                          "--disable-neon",
                          "--enable-libwebpdecoder",
                          "--enable-libwebpdemux",
                          "--enable-libwebpmux"
    system "make", "install"
  end
end
