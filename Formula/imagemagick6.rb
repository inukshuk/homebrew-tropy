class Imagemagick6 < Formula
  desc "Tools and libraries to manipulate images in many formats"
  homepage "https://www.imagemagick.org/"
  url "https://www.imagemagick.org/download/ImageMagick-6.9.11-0.tar.xz"
  sha256 "d90c4897407ac6004ed8015ae8be75b6760dcb068883b60d5edb3b5b092a1878"
  head "https://github.com/imagemagick/imagemagick6.git"
  revision 4

  bottle :unneeded
  conflicts_with "imagemagick@6",
    :because => "homebrew-core version of the same formula"

  depends_on "pkg-config" => :build

  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtool"
  depends_on "tropy/libvips/lcms2"
  depends_on "tropy/libvips/openjpeg2"

  def install
    #ENV.append 'PKG_CONFIG_PATH',
    #  "#{Formula['jpeg-turbo'].opt_lib}/pkgconfig"

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
      --without-modules
      --without-bzlib
      --without-djvu
      --without-dps
      --without-fftw
      --without-flif
      --without-fpx
      --without-freetype
      --without-gslib
      --without-gvc
      --without-heic
      --without-lqr
      --without-lzma
      --without-magick-plus-plus
      --without-openexr
      --without-pango
      --without-raqm
      --without-raw
      --without-rsvg
      --without-tiff
      --without-webp
      --without-wmf
      --without-x
      --without-xml
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
    %w[jp2 jpeg png].each do |feature|
      assert_match feature, features
    end
  end
end
