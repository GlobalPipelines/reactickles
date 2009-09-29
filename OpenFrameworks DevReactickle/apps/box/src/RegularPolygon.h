/*
 *  RegularPolygon.h
 *  openFrameworks iPhone
 *
 *  Created by Ed Burton on 03/09/2009.
 *
 */

#pragma once

#include "ofxBox2d.h"

class RegularPolygon : public ofxBox2dPolygon {
public:
	RegularPolygon(int edges,float radius);
	
	void draw() {
		const b2Vec2* verts=GetVertices();
		ofSetColor(255, 255, 0);
		ofFill();
		ofBeginShape();
		for(int i=0; i<vertexCount; i++) {
			ofVertex(verts[i].x*OFX_BOX2D_SCALE, verts[i].y*OFX_BOX2D_SCALE);
		}
		ofEndShape(true);
		delete [] verts;
	};
};