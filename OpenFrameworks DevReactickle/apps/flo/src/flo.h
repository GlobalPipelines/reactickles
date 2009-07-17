#pragma once

#include "ofMain.h"

#ifdef TARGET_OS_IPHONE
#include "ofxAccelerometer.h"
#include "ofxMultiTouch.h"
#endif

#ifndef TARGET_OS_IPHONE
class ofxMultiTouchListener {
public:
	ofxMultiTouchListener(){};
};
#endif

class timedPoint{
public:
	timedPoint(float x,float y,float t);
	float x;
	float y;
	float t;
};

class flo : public ofSimpleApp , public ofxMultiTouchListener {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void keyPressed(int key) {}
	void keyReleased(int key)  {}
#ifndef TARGET_OS_IPHONE
	void mouseMoved(int x, int y );
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased();
	void mouseReleased(int x, int y, int button );
#else
	void touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
#endif
	void addPointAt(int x,int y);
	
	vector<timedPoint> points;
	float *floAttenuation;
	float *radii;
	float outerRadius;
	float innerRadius;
	int maxPoints;
};

