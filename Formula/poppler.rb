class Poppler < Formula
  desc "PDF rendering library (based on the xpdf-3.0 code base)"
  homepage "https://poppler.freedesktop.org/"
  url "https://poppler.freedesktop.org/poppler-0.81.0.tar.xz"
  sha256 "212d020b035b67b36c9666bd08ac778dff3222d85c01c338787d546f0f9bfe02"
  head "https://anongit.freedesktop.org/git/poppler/poppler.git"

  bottle do
    sha256 "9b97533f63d2e09d7fdbeeff064015d43d7490cad118ca559d8c699985e9778c" => :catalina
    sha256 "c41c9aff6ed97d122c0806da50ed6ec8d9e7df118c38379530bf72850979927e" => :mojave
    sha256 "b55894e5ad440cd064a7dbac82510d91041d188501a9659f4ba76bef13acbe6d" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "glib"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "nss"
  depends_on "openjpeg"

  #resource "font-data" do
  #  url "https://poppler.freedesktop.org/poppler-data-0.4.9.tar.gz"
  #  sha256 "1f9c7e7de9ecd0db6ab287349e31bf815ca108a5a175cf906a90163bdbe32012"
  #end

  def install
    ENV.cxx11

    args = std_cmake_args + %w[
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
      -DENABLE_UNSTABLE_API_ABI_HEADERS=ON
      -DENABLE_LIBOPENJPEG=openjpeg2
    ]

    system "cmake", ".", *args
    system "make", "install/strip"

    #resource("font-data").stage do
    #  system "make", "install", "prefix=#{prefix}"
    #end

    libpoppler = (lib/"libpoppler.dylib").readlink
    [
      "#{lib}/libpoppler-glib.dylib"
    ].each do |f|
      macho = MachO.open(f)
      macho.change_dylib("@rpath/#{libpoppler}", "#{lib}/#{libpoppler}")
      macho.write!
    end
  end
end
