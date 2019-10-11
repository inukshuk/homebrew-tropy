class Librsvg2 < Formula
  desc "Library to render SVG files using Cairo"
  homepage "https://wiki.gnome.org/Projects/LibRsvg"
  url "https://download.gnome.org/sources/librsvg/2.46/librsvg-2.46.1.tar.xz"
  sha256 "2da1f2547a63a24ead121ad345011d5fd4f038ef46f74712ec82a1e85ec67643"

  bottle :unneeded

  conflicts_with "libtiff",
    :because => "homebrew-core version of the same formula"

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "cairo"
  depends_on "inukshuk/tropy/gdk-pixbuf2"
  depends_on "glib"
  depends_on "libcroco"
  depends_on "pango"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-introspection
      --disable-tools
      --prefix=#{prefix}
      --disable-Bsymbolic
      --enable-pixbuf-loader=yes
    ]

    system "./configure", *args

    # disable updating gdk-pixbuf cache, we will do this manually in post_install
    # https://github.com/Homebrew/homebrew/issues/40833
    inreplace "gdk-pixbuf-loader/Makefile",
              "$(GDK_PIXBUF_QUERYLOADERS) > $(DESTDIR)$(gdk_pixbuf_cache_file) ;",
              ""

    system "make", "install",
      "gdk_pixbuf_binarydir=#{lib}/gdk-pixbuf-2.0/2.10.0/loaders",
      "gdk_pixbuf_moduledir=#{lib}/gdk-pixbuf-2.0/2.10.0/loaders"
  end

  def post_install
    # librsvg is not aware GDK_PIXBUF_MODULEDIR must be set
    # set GDK_PIXBUF_MODULEDIR and update loader cache
    ENV["GDK_PIXBUF_MODULEDIR"] = "#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/2.10.0/loaders"
    system "#{Formula["gdk-pixbuf2"].opt_bin}/gdk-pixbuf-query-loaders", "--update-cache"
  end
end
