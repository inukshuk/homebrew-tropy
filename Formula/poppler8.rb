class Poppler8 < Formula
  desc "PDF rendering library (based on the xpdf-3.0 code base)"
  homepage "https://poppler.freedesktop.org/"
  url "https://poppler.freedesktop.org/poppler-0.86.1.tar.xz"
  sha256 "af630a277c8e194c31339c5446241834aed6ed3d4b4dc7080311e51c66257f6c"
  head "https://anongit.freedesktop.org/git/poppler/poppler.git"

  bottle :unneeded
  conflicts_with "poppler",
    :because => "homebrew-core version of the same formula"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "glib"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "tropy/libvips/libtiff4"
  depends_on "tropy/libvips/lcms2"
  depends_on "nss"
  depends_on "tropy/libvips/openjpeg2"

  #resource "font-data" do
  #  url "https://poppler.freedesktop.org/poppler-data-0.4.9.tar.gz"
  #  sha256 "1f9c7e7de9ecd0db6ab287349e31bf815ca108a5a175cf906a90163bdbe32012"
  #end

  def install
    ENV.cxx11

    args = std_cmake_args + %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DCMAKE_BUILD_TYPE=release
      -DCMAKE_CXX_FLAGS=-I#{Formula['jpeg-turbo'].opt_include}
      -DCMAKE_SHARED_LINKER_FLAGS=-L#{Formula['jpeg-turbo'].opt_lib}
      -DBUILD_GTK_TESTS=OFF
      -DBUILD_QT5_TESTS=OFF
      -DBUILD_CPP_TESTS=OFF
      -DBUILD_SHARED_LIBS=ON
      -DENABLE_CMS=lcms2
      -DENABLE_GLIB=ON
      -DENABLE_QT5=OFF
      -DENABLE_CPP=OFF
      -DENABLE_UTILS=OFF
      -DENABLE_SPLASH=OFF
      -DENABLE_LIBCURL=OFF
      -DENABLE_GOBJECT_INTROSPECTION=OFF
      -DENABLE_ZLIB_UNCOMPRESS=ON
      -DENABLE_UNSTABLE_API_ABI_HEADERS=OFF
      -DENABLE_LIBOPENJPEG=openjpeg2
    ]

    system "cmake", ".", *args
    system "make", "install/strip"

    #resource("font-data").stage do
    #  system "make", "install", "prefix=#{prefix}"
    #end

    #libpoppler = (lib/"libpoppler.dylib").readlink
    #[
    #  "#{lib}/libpoppler-glib.dylib"
    #].each do |f|
    #  macho = MachO.open(f)
    #  macho.change_dylib("@rpath/#{libpoppler}", "#{lib}/#{libpoppler}")
    #  macho.write!
    #end
  end
end
