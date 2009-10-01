#include "box.h"

//--------------------------------------------------------------
void box::setup(){	
	float w=ofGetWidth();
	float h=ofGetHeight();
	ofBackground(0,0,0);
	ofSetBackgroundAuto(true);
	ofEnableSmoothing();
	ofDisableAlphaBlending();
	box2d.init();
	float r=sqrt(w*w+h*h)/8;
	box2d.setBounds(ofPoint(-w*2,-h*2),ofPoint(w*3,h*3));
	box2d.setGravity(0, 0);
	box2d.checkBounds(false);
	box2d.setFPS(50.0);
	ofSetFrameRate(50.0);
	b2Vec2 centre((w/2)/OFX_BOX2D_SCALE,(h/2)/OFX_BOX2D_SCALE);
	b2BodyDef bd;
	bd.position.Set(0, 0);
	b2Body* ground = box2d.world->CreateBody(&bd);
	
	for (int c=0;c<30;c++) 
	{
		RegularPolygon poly(6,r);
		poly.setPhysics(1.0, 0.0, 0.0);
		poly.setup(box2d.getWorld(),ofRandom(-w, w*2)
				   , ofRandomf()>0?ofRandom(h+r, h*2):ofRandom(-h, -r));
		polygons.push_back(poly);
		b2MouseJointDef md(0.1,0.1);
		ofPoint op=poly.getB2DPosition();
		b2Vec2 p(op.x,op.y);
		md.body1 = ground;
		md.body2 = poly.body;
		md.target = p;
		md.maxForce = 1000.0f * poly.body->GetMass();
		b2MouseJoint* mj=(b2MouseJoint*)box2d.world->CreateJoint(&md);
		mj->SetTarget(centre);
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
	//box2d.draw();
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

