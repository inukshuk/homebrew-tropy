class Vips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.8.1/vips-8.8.1.tar.gz"
  sha256 "a0ee255a2a1ebfea5b2dff2a780824d7157a78c010d7ddd531279aacefbf2539"

  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "giflib"
  depends_on "glib"
  depends_on "imagemagick@6"
  depends_on "jpeg-turbo"
  depends_on "libexif"
  depends_on "libheif"
  depends_on "libpng"
  depends_on "librsvg"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "orc"
  depends_on "poppler"
  depends_on "webp"

  def install
    ENV.append 'PKG_CONFIG_PATH',
      "${Formula['imagemagick@6'].opt_lib}/pkgconfig"

    args = %W[
      --disable-dependency-tracking
      --disable-debug
      --disable-introspection
      --prefix=#{prefix}
      --with-jpeg-includes=#{Formula["jpeg-turbo"].opt_include}
      --with-jpeg-libraries=#{Formula["jpeg-turbo"].opt_lib}
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
      --without-python
      --without-radiance
      --without-x
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/vips", "-l"
    cmd = "#{bin}/vipsheader -f width #{test_fixtures("test.png")}"
    assert_equal "8", shell_output(cmd).chomp
  end
end
