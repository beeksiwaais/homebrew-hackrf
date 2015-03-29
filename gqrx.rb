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
index 24abc97..4d290ab 100644
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
@@ -30,8 +24,8 @@ CONFIG += link_pkgconfig
 unix:!macx {
     packagesExist(libpulse libpulse-simple) {
         # Comment out to use gr-audio (not recommended with ALSA and Funcube Dongle Pro)
-        AUDIO_BACKEND = pulse
-        message("Gqrx configured with pulseaudio backend")
+        #AUDIO_BACKEND = pulse
+        #message("Gqrx configured with pulseaudio backend")
     }
 }

@@ -48,7 +42,7 @@ isEmpty(PREFIX) {
 }

 target.path  = $$PREFIX/bin
-INSTALLS    += target
+INSTALLS    += target

 #CONFIG += debug

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

