class ImagemagickAT6 < Formula
  desc "Tools and libraries to manipulate images in many formats"
  homepage "https://www.imagemagick.org/"
  url "https://www.imagemagick.org/download/ImageMagick-6.9.10-68.tar.xz"
  sha256 "e1531c741296fa6289210a109d8737d3744652ef8f099f5f6cebdabf2decb2cb"
  head "https://github.com/imagemagick/imagemagick6.git"
  revision 1

  depends_on "pkg-config" => :build

  depends_on "fftw"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "libtool"
  depends_on "little-cms2"
  depends_on "openjpeg"

  def install
    ENV.append 'PKG_CONFIG_PATH',
      "${Formula['jpeg-turbo'].opt_lib}/pkgconfig"

    args = %W[
      --disable-osx-universal-binary
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-opencl
      --disable-openmp
      --disable-largefile
      --enable-shared
      --disable-static
      --with-openjp2
      --without-djvu
      --without-dps
      --without-flif
      --without-fpx
      --without-freetype
      --without-gslib
      --without-gvc
      --without-heic
      --without-lqr
      --without-lzma
      --without-magick-plus-plus
      --without-modules
      --without-openexr
      --without-pango
      --without-raqm
      --without-rsvg
      --without-webp
      --without-wmf
      --without-x
      --without-zlib
      --without-zstd
    ]

    # versioned stuff in main tree is pointless for us
    inreplace "configure", "${PACKAGE_NAME}-${PACKAGE_VERSION}", "${PACKAGE_NAME}"
    system "./configure", *args
    system "make", "install-strip"
  end

  test do
    assert_match "PNG", shell_output("#{bin}/identify #{test_fixtures("test.png")}")
    # Check support for recommended features and delegates.
    features = shell_output("#{bin}/convert -version")
    %w[jp2 png].each do |feature|
      assert_match feature, features
    end
  end
end
