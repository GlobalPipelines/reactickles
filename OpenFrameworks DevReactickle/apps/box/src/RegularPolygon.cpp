/*
 *  RegularPolygon.cpp
 *  openFrameworks iPhone
 *
 *  Created by Ed Burton on 03/09/2009.
 *
 */

#include "RegularPolygon.h"

RegularPolygon::RegularPolygon(int edges,float radius) : ofxBox2dPolygon() {
	for(int i=0; i<edges; i++) {
		float a=(TWO_PI*i)/edges; 
		float x=cos(a)*radius;
		float y=sin(a)*radius;
		addVertex(x, y);
	}
}