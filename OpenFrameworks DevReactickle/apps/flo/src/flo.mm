#include "flo.h"

//--------------------------------------------------------------
void flo::setup(){	
	ofBackground(0,0,0);
	ofSetBackgroundAuto(true);
	ofDisableAlphaBlending();
	int w=ofGetScreenWidth();
	int h=ofGetScreenHeight();
	float diagonal=sqrt(w*w+h*h);
#ifdef TARGET_OS_IPHONE
	glEnableClientState( GL_VERTEX_ARRAY );  // this should be in OF somewhere.  
	ofSetCircleResolution(8);
	ofxMultiTouch.addListener(this);
	outerRadius=diagonal/20;
	maxPoints=400;
#else
	outerRadius=diagonal/30;
	maxPoints=4000;
#endif
	innerRadius=outerRadius*.75;
	radii=new float[maxPoints];
	floAttenuation=new float[maxPoints];
	for (int i=0;i<maxPoints;i++) {
		floAttenuation[i]=pow(i/(float)maxPoints,1/3.0);
	}
}


//--------------------------------------------------------------
void flo::update(){
	if (points.size()>0) {
		vector<timedPoint>::iterator it= points.begin();
		float time=ofGetElapsedTimef();
		for(it = points.begin(); it != points.end() && !points.empty(); it++)
			if (time-it->t>30)
				points.erase(it);
			else
				break;
	}
}

//--------------------------------------------------------------
void flo::draw(){
	float time=ofGetElapsedTimef();
	int s=points.size();
	int offset=maxPoints-s;
	for (int i=0;i<s;i++) {
		float r=pow(sin((time-points[i].t)*PI),3);
		radii[i]=r*floAttenuation[i+offset];
	}
	ofSetColor(255,0,0);
	for (int i=0;i<s;i++)
		ofCircle(points[i].x, points[i].y, radii[i]*outerRadius);
	ofSetColor(255,255,0);
	for (int i=0;i<s;i++)
		ofCircle(points[i].x, points[i].y, radii[i]*innerRadius*.75);
}

void flo::addPointAt(int x,int y)
{
	points.push_back( timedPoint(x,y,ofGetElapsedTimef()));
	if (points.size()>=maxPoints) {
		vector<timedPoint>::iterator it= points.begin();
		points.erase(it);
	}
}

void flo::exit() {
}

#ifndef TARGET_OS_IPHONE
//--------------------------------------------------------------
void flo::mouseMoved(int x, int y ){
	
}

//--------------------------------------------------------------
void flo::mouseDragged(int x, int y, int button){
	touchMoved(x,y,0,NULL);
}


//--------------------------------------------------------------
void flo::mousePressed(int x, int y, int button){
	touchDown(x,y,0,NULL);
}

//--------------------------------------------------------------
void flo::mouseReleased(){
}

//--------------------------------------------------------------
void flo::mouseReleased(int x, int y, int button){
	
}
#endif

//--------------------------------------------------------------
void flo::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	addPointAt(x,y);
}
//--------------------------------------------------------------
void flo::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	addPointAt(x,y);
}
//--------------------------------------------------------------
void flo::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	
}
//--------------------------------------------------------------
void flo::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	points.clear();
}


timedPoint::timedPoint(float xx,float yy, float tt){
	x=xx;
	y=yy;
	t=tt;
}
