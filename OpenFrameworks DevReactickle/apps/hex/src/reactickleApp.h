#pragma once

#include "ofMain.h"
#include "ofVectorMath.h"
#include "RegularPolygon.h"
#include "ofxBox2d.h"

#if TARGET_OS_IPHONE
#include "ofxMultiTouch.h"
#else
class ofxMultiTouchListener {
public:
	ofxMultiTouchListener(){};
};
class ofxMultiTouchCustomData {
public:
	ofxMultiTouchCustomData(){};
};
#endif

class reactickle : public ofSimpleApp , public ofxMultiTouchListener {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void keyPressed(int key)  {}
	void keyReleased(int key)  {}
#if !TARGET_OS_IPHONE
	void mouseMoved(int x, int y );
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased();
	void mouseReleased(int x, int y, int button );
#endif
	void touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	
	
	ofxBox2d						box2d;			  //	the box2d world
	vector		<RegularPolygon>	polygons;			
};

