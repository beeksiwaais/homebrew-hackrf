require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
# from: https://github.com/xlfe/homebrew-gnuradio

class Gqrx < Formula
  homepage 'https://github.com/csete/gqrx'
  head 'https://github.com/csete/gqrx.git', :branch => 'v2.3.x'

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
index 2571518..c142c01 100644
--- i/gqrx.pro
+++ w/gqrx.pro
@@ -11,17 +11,13 @@ contains(QT_MAJOR_VERSION,5) {

 TEMPLATE = app

-macx {
-    TARGET = Gqrx
-    ICON = icons/scope.icns
-    DEFINES += GQRX_OS_MACX
-} else {
-    TARGET = gqrx
-}
+
+TARGET = gqrx
+

 linux-g++|linux-g++-64 {
     # Comment out to use gr-audio (gr 3.6.5.1 or later recommended)
-    AUDIO_BACKEND = pulse
+    #AUDIO_BACKEND = pulse
 }

 RESOURCES += icons.qrc
@@ -155,28 +151,19 @@ contains(AUDIO_BACKEND, pulse): {

 # dependencies via pkg-config
 # FIXME: check for version?
-unix {
-    CONFIG += link_pkgconfig
-
-    contains(AUDIO_BACKEND, pulse): {
-        PKGCONFIG += libpulse libpulse-simple
-    } else {
-        PKGCONFIG += gnuradio-audio
-    }
-    PKGCONFIG += gnuradio-core gnuradio-osmosdr
-}

 unix:!macx {
     LIBS += -lboost_system -lboost_program_options
     LIBS += -lrt  # need to include on some distros
 }

-macx-g++ {
-     LIBS += -lboost_system-mt -lboost_program_options-mt
-#    INCLUDEPATH += /usr/local/include
-#    INCLUDEPATH += /usr/local/include/gnuradio
-#    INCLUDEPATH += /usr/local/include/osmosdr
-#    INCLUDEPATH += /opt/local/include
+macx {
+     LIBS += -lboost_system-mt -lboost_program_options-mt -lgnuradio-audio -lgnuradio-core -lgnuradio-osmosdr -lgruel
+     LIBPATH += /usr/loca/lib
+     INCLUDEPATH += /usr/local/include
+     INCLUDEPATH += /usr/local/include/gnuradio
+     INCLUDEPATH += /usr/local/include/osmosdr
+     INCLUDEPATH += /opt/local/include
 }

 OTHER_FILES += \
