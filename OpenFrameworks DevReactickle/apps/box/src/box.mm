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
	int wc=3;
	int hc=5;
	float bw=w/(wc+2);
	float bh=h/(hc+2);
	int c=0;
	for (int xi =0;xi<wc;xi++){
		float x1=bw+xi*bw;
		for (int yi =0;yi<hc;yi++){
			if (c++<19) {
				float y1=bh+yi*bh;
				RegularPolygon poly(6,30);
				poly.setPhysics(1.0, 0.4, 0.2);
				poly.setup(box2d.getWorld(), x1+bw/2, y1+bh/2);
				polygons.push_back(poly);
			}
		}
	}
	
#if TARGET_OS_IPHONE==1
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
	for(int i=0; i<polygons.size(); i++) {
		polygons[i].draw();
	}
	box2d.draw();
}
void box::exit() {
}

#if !TARGET_OS_IPHONE
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

