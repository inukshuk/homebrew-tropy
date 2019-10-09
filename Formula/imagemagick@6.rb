class ImagemagickAT6 < Formula
  desc "Tools and libraries to manipulate images in many formats"
  homepage "https://www.imagemagick.org/"
  url "https://www.imagemagick.org/download/ImageMagick-6.9.10-68.tar.xz"
  #sha256 "b963f05fc73ece7b1fa392ff47a5f1fd74ef3a39da25186ee35c3ed47e1f1dd9"
  head "https://github.com/imagemagick/imagemagick6.git"

  bottle do
    sha256 "e339734f14df8c40e341ce7c65b71716af05364b67c150a99a6d77abdb6a4041" => :catalina
    sha256 "27135af537f6a6439e055ecf806701c5fb9323e4113c5ec7aff2761390b82f77" => :mojave
    sha256 "0b6fc8fd65ee21827e46ace31ecbc5574f4d1652977291052cdfa2007b814be8" => :high_sierra
    sha256 "5db0568d8a8d028fdc885642e683a362bdf635b5d3d611135b9bbe2271bf757a" => :sierra
  end

  keg_only :versioned_formula

  depends_on "pkg-config" => :build

  depends_on "fftw"
  depends_on "jpeg_turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "libtool"
  depends_on "little-cms2"
  depends_on "openjpeg"

  def install
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
