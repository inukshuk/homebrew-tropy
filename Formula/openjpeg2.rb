class Openjpeg2 < Formula
  desc "Library for JPEG-2000 image manipulation"
  homepage "https://www.openjpeg.org/"
  url "https://github.com/uclouvain/openjpeg/archive/v2.3.1.tar.gz"
  sha256 "63f5a4713ecafc86de51bfad89cc07bb788e9bba24ebbf0c4ca637621aadb6a9"
  head "https://github.com/uclouvain/openjpeg.git"

  bottle :unneeded
  conflicts_with "openjpeg",
    :because => "homebrew-core version of the same formula"

  depends_on "cmake" => :build
  depends_on "libpng"
  depends_on "inukshuk/tropy/libtiff4"
  depends_on "inukshuk/tropy/lcms2"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install/strip"
  end
end
