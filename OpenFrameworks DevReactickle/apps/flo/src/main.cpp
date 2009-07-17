#include "ofMain.h"
#include "flo.h"

int main(int argc, char *argv[]) {
	int w=1024;
	int h=768;
	int mode=OF_GAME_MODE;
#ifdef TARGET_OS_IPHONE
	mode=OF_FULLSCREEN;
#endif
	if (mode==OF_GAME_MODE)
		w=h=9999;                       // attempts to use highest available resolution on desktop
	ofSetupOpenGL(w,h, mode);			// <-------- setup the GL context
	ofRunApp(new flo);
}
