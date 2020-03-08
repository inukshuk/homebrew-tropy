class Libvips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.9.1/vips-8.9.1.tar.gz"
  sha256 "45633798877839005016c9d3494e98dee065f5cb9e20f4552d3b315b8e8bce91"

  bottle :unneeded
  conflicts_with 'vips',
    :because => 'homebrew-core version of the same formula'

  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "giflib"
  depends_on "glib"
  depends_on "tropy/libvips/imagemagick6"
  depends_on "jpeg-turbo"
  depends_on "libexif"
  depends_on "tropy/libvips/libheif1"
  depends_on "libpng"
  depends_on "tropy/libvips/librsvg2"
  depends_on "tropy/libvips/libtiff4"
  depends_on "tropy/libvips/lcms2"
  depends_on "orc"
  depends_on "tropy/libvips/poppler8"
  depends_on "tropy/libvips/webp1"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-debug
      --disable-introspection
      --disable-static
      --enable-shared
      --without-OpenEXR
      --without-analyze
      --without-gsf
      --without-imagequant
      --without-matio
      --without-nifti
      --without-openslide
      --without-pangoft2
      --without-pdfium
      --without-ppm
      --without-radiance
      --without-x
      --with-heif
      --with-libwebp
      --with-magick
      --with-poppler
      --with-jpeg-includes=#{Formula["jpeg-turbo"].opt_include}
      --with-jpeg-libraries=#{Formula["jpeg-turbo"].opt_lib}
    ]

    system "./configure", *args
    system "make", "install-strip"
  end

  test do
    system "#{bin}/vips", "-l"
    cmd = "#{bin}/vipsheader -f width #{test_fixtures("test.png")}"
    assert_equal "8", shell_output(cmd).chomp
  end
end
