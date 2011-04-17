//
//  PolesZerosView.m
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "PolesZerosView.h"


#define FILTER_TOUCH_RADIUS 50


@implementation PolesZerosView



- (void) drawRect : (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    // draw grid lines
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.225);
    CGContextSetLineWidth(context, 1);
    
    for (int i=0; i<[UIScreen mainScreen].bounds.size.width; i+=30) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, i, [UIScreen mainScreen].bounds.size.height);
        CGContextAddLineToPoint(context, i, [UIScreen mainScreen].bounds.size.height);
        CGContextAddLineToPoint(context, i, 0);    
        CGContextStrokePath(context);
        
    }
    for (int i=0; i<[UIScreen mainScreen].bounds.size.height; i+=30) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, [UIScreen mainScreen].bounds.size.width, i);
        CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, i);
        CGContextAddLineToPoint(context, 0, i);    
        CGContextStrokePath(context);
    }

    // draw unit circle
    CGContextSetRGBStrokeColor(context, 255, 255, 255, 1);
    CGContextSetLineWidth(context, 4);

    
    CGFloat x = self.frame.size.width/2.0 + self.frame.origin.x;
    CGFloat y = self.frame.size.height/2.0 + self.frame.origin.y;  
    
   // CGFloat x = (self.frame.size.width - self.frame.origin.x)/2.0;
   // CGFloat y = (self.frame.size.height - self.frame.origin.y)/2.0;  
    
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width, y);
    CGContextAddLineToPoint(context, self.frame.size.width, y);
    CGContextAddLineToPoint(context, 0, y);    
    CGContextStrokePath(context);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x, self.frame.size.height);
    CGContextAddLineToPoint(context, x, self.frame.size.height);
    CGContextAddLineToPoint(context, x, 0);    
    CGContextStrokePath(context);

    CGContextSetRGBStrokeColor(context, 255, 255, 255, 1);
    CGContextSetLineWidth(context, 6);
    
    
//    if (self.frame.size.width > self.frame.size.height) {
//        CGRect fr = CGRectMake(self.frame.origin.x + self.frame.size.width/2.0 - self.frame.size.height/2.0, self.frame.origin.y, self.frame.size.height, self.frame.size.height);
//        CGContextStrokeEllipseInRect(context, fr);
//    } else {
//        CGRect fr = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height/2.0 - self.frame.size.width/2.0, self.frame.size.width, self.frame.size.width);
//        CGContextStrokeEllipseInRect(context, fr);        
//    }
    
    CGFloat s = (self.frame.size.width < self.frame.size.height) ? self.frame.size.width : self.frame.size.height;
    s *= 0.95;
    float subS = s/2.0;
    x -= subS;
    y -= subS;    
    CGRect f = CGRectMake(x, y, s,s);
    CGContextStrokeEllipseInRect(context, f);

// why doesn't this work for split views?  
//    CGContextStrokeEllipseInRect(context, self.frame);

    
    //dots
    x = self.frame.size.width/2.0;
    y = self.frame.size.height/2.0;
    
    for (int i=0; i<[points count]; i++) {
        NSValue *value = [points objectAtIndex:i];
        CGPoint p = [value CGPointValue];
        CGFloat xx = p.x;
        CGFloat yy = p.y;
//        CGContextStrokeEllipseInRect(context, CGRectMake(xx,yy, 30,30));
      
        
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);
        CGContextSetLineWidth(context, 2);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x, y);
        CGContextAddLineToPoint(context, xx, yy);    
        CGContextStrokePath(context);

        
        // draw arrow http://stackoverflow.com/questions/2500197/drawing-triangle-arrow-on-a-line-with-cgcontext
        CGFloat r, ax, ay, bx, by, cx, cy, dy, dx;
        
        // length and width are 
        CGFloat length, width;
        width = 10;
        length = 10; 
        CGPoint m = CGPointMake(x, y);
        CGPoint n = CGPointMake(xx, yy);
        
        r = atan2( n.y - m.y , n.x - m.x );
        r += M_PI;
        bx = n.x;
        by = n.y;
        dx = bx + cos( r ) * length;
        dy = by + sin( r ) * length;
        r += M_PI_2; // perpendicular to path
        ax = dx + cos( r ) * width;
        ay = dy + sin( r ) * width;
        cx = dx - cos( r ) * width;
        cy = dy - sin( r ) * width;
        
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);
        CGContextSetRGBFillColor(context, 255,255,255,1);
        CGContextSetLineWidth(context, 3);
        
        CGContextBeginPath(context);
        CGContextMoveToPoint( context , ax , ay );
        CGContextAddLineToPoint( context , bx , by );
        CGContextAddLineToPoint( context , cx , cy );
        CGContextFillPath(context);
        
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    bool flag = true;
    for(UITouch *t in touches) {
        CGPoint theTouch = [t locationInView:self];
        for (int i=0; i<[points count]; i++) {
            CGFloat dist = [self pDist : theTouch point2: [[points objectAtIndex:i] CGPointValue]];
            if (dist <= FILTER_TOUCH_RADIUS) {
                if([t tapCount] == 2) {
                    [points removeObject:[points objectAtIndex:i]];
                } else {
                    // 1 tap
                    [points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:theTouch]];     
                } 
                flag = false;
                break;
            } 
        }
        
        imagePoint = theTouch;
        
        // going to add, naive is to append to array. 
        
        if (flag) { 
            
            
            [self addPoint:theTouch];
            
        }
    }
}

- (float) pDist : (CGPoint) a point2: (CGPoint) b {
    float x = a.x - b.x;
    float y = a.y - b.y;
    return sqrt(x*x + y*y);
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for(UITouch *t in touches) {
        CGPoint a = [t locationInView:self];
        imagePoint = a;
        for (int i=0; i<[points count]; i++) {
            NSValue *value = [points objectAtIndex:i];
            CGPoint p = [value CGPointValue];
            //CGFloat dist = [self pDist : a point2: p];
            CGFloat dist = [self pDist : a point2: p];
            if (dist <= FILTER_TOUCH_RADIUS) {
                
                [points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:a]];              
                break;
            }
            
        }
    }
    
    
    
    
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}

- (void) addPoint : (CGPoint) point {
    if (!points) {
        points = [[NSMutableArray alloc] init];
    }
    
    if ([points count] > 2) {
        
        float lastDist = FLT_MAX;
        bool foundit = false;
        int myIndex = 0;
        for (int i=0; i<[points count]; i++) {
           
            float dist = [[points objectAtIndex:i] CGPointValue].x - point.x;
            if (dist < 0) continue;
            if (dist <= lastDist) {
                foundit = true;
                lastDist = dist;
                myIndex = i;
            }
            
        }
        if (foundit) [points insertObject:[NSValue valueWithCGPoint:point] atIndex:myIndex];
        else [points addObject: [NSValue valueWithCGPoint: point]];
    } else {
        [points addObject: [NSValue valueWithCGPoint: point]];
    }
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}


- (void)dealloc {
    [points dealloc];
    [super dealloc];
}




@end
