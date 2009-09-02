#include "box.h"

//--------------------------------------------------------------
void box::setup(){	
	ofBackground(0,0,0);
	ofSetBackgroundAuto(true);
	ofDisableAlphaBlending();
	
	box2d.init();
	box2d.setGravity(0, 9.8);
	box2d.createBounds();
	box2d.checkBounds(true);
	box2d.setFPS(50.0);
	ofSetFrameRate(50.0);
	
	float w=ofGetWidth();
	float h=ofGetHeight();
	int wc=6;
	int hc=3;
	float bw=w/(wc+2);
	float bh=h/(hc+2);
	for (int xi =0;xi<wc;xi++){
		float x1=bw+xi*bw;
		for (int yi =0;yi<hc;yi++){
			if ((xi+yi)%2) {
				float y1=bh+yi*bh;
				ofxBox2dRect rect;
				rect.setPhysics(1.0, 0.4, 0.2);
				rect.setup(box2d.getWorld(), x1+bw/2, y1+bh/2, bw/2, bh/2);
				boxes.push_back(rect);
			}
		}
	}
	
#ifdef TARGET_OS_IPHONE
	glEnableClientState( GL_VERTEX_ARRAY );  // this should be in OF somewhere.  
	ofSetCircleResolution(8);
	ofxMultiTouch.addListener(this);
#else
	
	
#endif
}


//--------------------------------------------------------------
void box::update(){
	box2d.update();
}

//--------------------------------------------------------------
void box::draw(){
	for(int i=0; i<boxes.size(); i++) {
		boxes[i].draw();
	}
	box2d.draw();
}
void box::exit() {
}

#ifndef TARGET_OS_IPHONE
//--------------------------------------------------------------
void box::mouseMoved(int x, int y ){
	
}

//--------------------------------------------------------------
void box::mouseDragged(int x, int y, int button){
	touchMoved(x,y,0);
}


//--------------------------------------------------------------
void box::mousePressed(int x, int y, int button){
	touchDown(x,y,0);
}

//--------------------------------------------------------------
void box::mouseReleased(){
	touchUp(0,0,0);
}

//--------------------------------------------------------------
void box::mouseReleased(int x, int y, int button){
	touchUp(x,y,0);
}

#endif

//--------------------------------------------------------------
void box::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	box2d.manipulatorPressed(x,y,touchId);
}
//--------------------------------------------------------------
void box::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	box2d.manipulatorDragged(x,y,touchId);
}
//--------------------------------------------------------------
void box::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	box2d.manipulatorReleased(x,y,touchId);
}
//--------------------------------------------------------------
void box::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	
}

