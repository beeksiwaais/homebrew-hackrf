require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
# from: https://github.com/xlfe/homebrew-gnuradio

class Gqrx < Formula
  homepage 'https://github.com/csete/gqrx'
  head 'https://github.com/csete/gqrx.git', :branch => 'master'

  depends_on 'cmake' => :build
  depends_on 'qt'
#brew install --with-c+11 --universal boost
  depends_on 'boost'
  depends_on 'gnuradio'

  def patches
    #patch to compile to binary, comment out pulse audio and link boost correctly
    DATA
  end

  def install
    system "qmake -set PKG_CONFIG /usr/local/bin/pkg-config"
    system "qmake -query"
    system "qmake gqrx.pro"
    system "make"
    bin.install 'gqrx.app/Contents/MacOS/gqrx'
  end
end
__END__

diff --git i/gqrx.pro w/gqrx.pro
index 24abc97..53eef5a 100644
--- i/gqrx.pro
+++ w/gqrx.pro
@@ -16,13 +16,7 @@ contains(QT_MAJOR_VERSION,5) {

 TEMPLATE = app

-macx {
-    TARGET = Gqrx
-    ICON = icons/gqrx.icns
-    DEFINES += GQRX_OS_MACX
-} else {
-    TARGET = gqrx
-}
+TARGET = gqrx

 # enable pkg-config to find dependencies
 CONFIG += link_pkgconfig
@@ -211,6 +205,11 @@ unix:!macx {

 macx {
     LIBS += -lboost_system-mt -lboost_program_options-mt
+    LIBPATH += /usr/loca/lib
+    INCLUDEPATH += /usr/local/include
+    INCLUDEPATH += /usr/local/include/gnuradio
+    INCLUDEPATH += /usr/local/include/osmosdr
+    INCLUDEPATH += /opt/local/include
 }

 OTHER_FILES += \
