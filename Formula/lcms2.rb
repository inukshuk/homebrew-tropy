class Lcms2 < Formula
  desc "Color management engine supporting ICC profiles"
  homepage "http://www.littlecms.com/"
  # Ensure release is announced on http://www.littlecms.com/download.html
  url "https://downloads.sourceforge.net/project/lcms/lcms/2.9/lcms2-2.9.tar.gz"
  sha256 "48c6fdf98396fa245ed86e622028caf49b96fa22f3e5734f853f806fbc8e7d20"
  version_scheme 1

  bottle :unneeded
  conflicts_with "little-cms2",
    :because => "homebrew-core version of the same formula"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --without-jpeg
      --without-tiff
    ]

    system "./configure", *args
    system "make", "install-strip"
  end
end
