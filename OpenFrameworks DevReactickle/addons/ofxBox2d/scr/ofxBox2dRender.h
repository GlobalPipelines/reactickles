#pragma once
#include "ofMain.h"
#include "Box2D.h"

class ofxBox2dRender : public b2DebugDraw {
	
public:
	
	float scaleFactor;
	
	void setScale(float f) {
		scaleFactor = f;
	}
	
	void DrawPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color) {
		ofSetColor(color.r, color.g, color.b);
		ofBeginShape();
		for (int32 i = 0; i < vertexCount; ++i)
		{
			ofVertex(vertices[i].x*OFX_BOX2D_SCALE, vertices[i].y*OFX_BOX2D_SCALE);
		}
		ofEndShape(true);
	}
	void DrawSolidPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color) {
		
		ofSetColor(0xffffff);
		ofBeginShape();
		for(int i=0; i<vertexCount; ++i) {
			ofVertex(vertices[i].x*OFX_BOX2D_SCALE, vertices[i].y*OFX_BOX2D_SCALE);
		}
		ofEndShape();
		
		/*glEnable(GL_BLEND);
		glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glColor4f(0.5f * color.r, 0.5f * color.g, 0.5f * color.b, 0.5f);
		glBegin(GL_TRIANGLE_FAN);
		for(int32 i = 0; i < vertexCount; ++i) {
			glVertex2f(vertices[i].x*scaleFactor, vertices[i].y*scaleFactor);
		}
		glEnd();
		glDisable(GL_BLEND);
		
		glColor4f(color.r, color.g, color.b, 1.0f);
		glBegin(GL_LINE_LOOP);
		for (int32 i = 0; i < vertexCount; ++i) {
			glVertex2f(vertices[i].x*scaleFactor, vertices[i].y*scaleFactor);
		}
		glEnd();*/
	
	}
	void DrawCircle(const b2Vec2& center, float32 radius, const b2Color& color) {
		ofNoFill();
		ofSetColor(color.r, color.g, color.b);
		ofCircle(center.x*scaleFactor, center.y*scaleFactor, radius);
		
		
	}
	void DrawSolidCircle(const b2Vec2& center, float32 radius, const b2Vec2& axis, const b2Color& color) {
		float rad = (radius*scaleFactor);
		ofSetColor(255, 255, 255, 200);
		ofFill();
		ofCircle(center.x*scaleFactor, center.y*scaleFactor, rad);
	}
	void DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color) {
		ofSetColor(255, 255, 255, 200);
		ofLine(p1.x*OFX_BOX2D_SCALE, p1.y*OFX_BOX2D_SCALE,p2.x*OFX_BOX2D_SCALE, p2.y*OFX_BOX2D_SCALE);
	}
	void DrawXForm(const b2XForm& xf) {
	}
	void DrawPoint(const b2Vec2& p, float32 size, const b2Color& color) {
	}
	void DrawString(int x, int y, const char* string, ...) {
	}
	void DrawAABB(b2AABB* aabb, const b2Color& color) {
		ofNoFill();
		ofSetColor(color.r, color.g, color.b);
		ofBeginShape();
		ofVertex(aabb->lowerBound.x, aabb->lowerBound.y);
		ofVertex(aabb->upperBound.x, aabb->lowerBound.y);
		ofVertex(aabb->upperBound.x, aabb->upperBound.y);
		ofVertex(aabb->lowerBound.x, aabb->upperBound.y);
		ofEndShape(true);
	}
	
};