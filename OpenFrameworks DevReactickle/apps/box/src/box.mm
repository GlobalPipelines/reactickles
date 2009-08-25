#include "box.h"

//--------------------------------------------------------------
void box::setup(){	
	ofBackground(0,0,0);
	ofSetBackgroundAuto(true);
	ofDisableAlphaBlending();
	
	mouseJoint = NULL;
	
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
			float y1=bh+yi*bh;
			ofxBox2dRect rect;
			rect.setPhysics(1.0, 0.4, 0.2);
			rect.setup(box2d.getWorld(), x1+bw/2, y1+bh/2, bw/3, bh/3);
			boxes.push_back(rect);
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
	//box2d.draw();
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
	b2Vec2 p(x/OFX_BOX2D_SCALE, y/OFX_BOX2D_SCALE);
	
	if (mouseJoint != NULL) {
		return;
	}
	
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	
	// Query the world for overlapping shapes.
	const int32 k_maxCount = 10000;
	b2Shape* shapes[k_maxCount];
	int32 count = box2d.world->Query(box2d.worldAABB, shapes, k_maxCount);
	b2Body* body = NULL;
	
	for (int32 i = 0; i < count; ++i) {
		
		b2Body* shapeBody = shapes[i]->GetBody();
		if (shapeBody->IsStatic() == false && shapeBody->GetMass() > 0.0f) {
			bool inside = shapes[i]->TestPoint(shapeBody->GetXForm(), p);
			if (inside) {
				body = shapes[i]->GetBody();
				break;
			}
		}
	}
	
	if (body) {
		
		b2MouseJointDef md;
		md.body1 = box2d.world->GetGroundBody();
		md.body2 = body;
		md.target = p;
#ifdef TARGET_FLOAT32_IS_FIXED
		md.maxForce = (body->GetMass() < 16.0)? 
		(1000.0f * body->GetMass()) : float32(16000.0);
#else
		md.maxForce = 1000.0f * body->GetMass();
#endif
		mouseJoint = (b2MouseJoint*)box2d.world->CreateJoint(&md);
		body->WakeUp();
		
	}	
}
//--------------------------------------------------------------
void box::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	b2Vec2 p(x/OFX_BOX2D_SCALE, y/OFX_BOX2D_SCALE);
	if (mouseJoint) mouseJoint->SetTarget(p);
}
//--------------------------------------------------------------
void box::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	if(mouseJoint) {
		box2d.world->DestroyJoint(mouseJoint);
		mouseJoint = NULL;
	}
}
//--------------------------------------------------------------
void box::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	
}

