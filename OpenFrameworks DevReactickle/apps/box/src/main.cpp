#include "ofMain.h"
#include "box.h"

int main(int argc, char *argv[]) {
	int w=320;
	int h=396;
	int mode=OF_WINDOW;
#if TARGET_OS_IPHONE
	mode=OF_FULLSCREEN;
#endif
	if (mode==OF_GAME_MODE)
		w=h=9999;                       // attempts to use highest available resolution on desktop
	ofSetupOpenGL(w,h, mode);			// <-------- setup the GL context
	ofRunApp(new box);
}
