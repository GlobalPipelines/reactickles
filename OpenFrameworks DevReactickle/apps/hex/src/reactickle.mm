#include "hex.h"

//--------------------------------------------------------------
void hex::setup(){	
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
	int wc=5;
	int hc=5;
	float bw=w/(wc+2);
	float bh=h/(hc+2);
	for (int xi =0;xi<wc;xi++){
		float x1=bw+xi*bw;
		for (int yi =0;yi<hc;yi++){
			float y1=bh+yi*bh;
			ofxBox2dRect rect;
			rect.setPhysics(1.0, 0.6, 0.0);
			rect.setup(box2d.getWorld(), x1+bw/2+ofRandom(-bw/6, bw/6), y1+bh/2+ofRandom(-bh/6, bh/6), bw/2.5, bh/2.5);
			boxes.push_back(rect);
		}
	}
	
#if TARGET_OS_IPHONE
	glEnableClientState( GL_VERTEX_ARRAY );  // this should be in OF somewhere.  
	ofSetCircleResolution(8);
	ofxMultiTouch.addListener(this);
#else
	
	
#endif
}


//--------------------------------------------------------------
void hex::update(){
	box2d.update();
}

//--------------------------------------------------------------
void hex::draw(){
	for(int i=0; i<boxes.size(); i++) {
		boxes[i].draw();
	}
	//box2d.draw();
}
void hex::exit() {
}

#if !TARGET_OS_IPHONE
//--------------------------------------------------------------
void hex::mouseMoved(int x, int y ){
	
}

//--------------------------------------------------------------
void hex::mouseDragged(int x, int y, int button){
	
}


//--------------------------------------------------------------
void hex::mousePressed(int x, int y, int button){
	
}

//--------------------------------------------------------------
void hex::mouseReleased(){
}

//--------------------------------------------------------------
void hex::mouseReleased(int x, int y, int button){
	
}

#else

//--------------------------------------------------------------
void hex::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	
}
//--------------------------------------------------------------
void hex::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	
}
//--------------------------------------------------------------
void hex::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	
}
//--------------------------------------------------------------
void hex::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	
}
#endif
