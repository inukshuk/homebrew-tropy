class Libvips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.8.1/vips-8.8.1.tar.gz"
  sha256 "a0ee255a2a1ebfea5b2dff2a780824d7157a78c010d7ddd531279aacefbf2539"

  conflicts_with 'vips',
    :because => 'homebrew-core version of the same formula'

  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "giflib"
  depends_on "glib"
  depends_on "inukshuk/tropy/imagemagick@6"
  depends_on "jpeg-turbo"
  depends_on "libexif"
  depends_on "libheif"
  depends_on "libpng"
  depends_on "librsvg"
  depends_on "inukshuk/tropy/libtiff"
  depends_on "little-cms2"
  depends_on "orc"
  depends_on "inukshuk/tropy/poppler"
  depends_on "webp"

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
