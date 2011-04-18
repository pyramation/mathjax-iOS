#import "FilterDesign.h"
#import "Axis.h"

#define FILTER_TOUCH_RADIUS 50


@implementation FilterDesign
@synthesize axis;

- (CGPoint) lerp : (CGPoint) a p2 : (CGPoint) b time: (float) u {
    CGPoint c;
    c.x = a.x + (b.x - a.x)*u;
    c.y = a.y + (b.y - a.y)*u;
    return c;
}

- (CGPoint) deCasteljau : (NSMutableArray *) array time: (float) u {
    
    if (![array count]) {
        CGPoint a;
        a.x = a.y = 0.0;
        return a;
    }
    if ([array count] == 1) {
        NSValue *value = [array objectAtIndex:0];
        CGPoint p = [value CGPointValue];
        return p;
    }
    
    NSMutableArray *pv =  [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[array count]-1; i++) {
        CGPoint pt1 =  [[array objectAtIndex:i] CGPointValue];
        CGPoint pt2 = [[array objectAtIndex:i+1] CGPointValue];
        [pv addObject:[NSValue valueWithCGPoint: [self lerp:pt1 p2:pt2 time:u]]];        
    }
    
    CGPoint a = [self deCasteljau:pv time:u];
    [pv release];
    return a;
}


- (void) drawRect : (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
// draw grid lines
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.125);
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
        
    float level = 100.0;

// draw fill    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, [UIScreen mainScreen].bounds.size.height);
    CGContextAddLineToPoint(context, 0, [UIScreen mainScreen].bounds.size.height);
    for(float u=0; u<=1; u+= 1.0/level) {
        CGPoint a = [self deCasteljau: points time:u];  
        CGContextAddLineToPoint(context, a.x, a.y);
    }
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGContextSetRGBFillColor(context, 0,40,255,0.2);
    CGContextFillPath(context);

// draw stoke
    CGContextSetLineWidth(context, 5);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, [UIScreen mainScreen].bounds.size.height);
    CGContextAddLineToPoint(context, 0, [UIScreen mainScreen].bounds.size.height);
    for(float u=0; u<=1; u+= 1.0/level) {
        CGPoint a = [self deCasteljau: points time:u];  
        CGContextAddLineToPoint(context, a.x, a.y);
    }
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);
    CGContextStrokePath(context);

 //dots
    [self plotPoints:rect theContext:context];

    

    

//    if ([points count] > 4) {         
//    CGContextBeginPath(context);
//        if (TRUE) {
//            if ([points count] > 0) {
//                CGPoint first =  [[points objectAtIndex:0] CGPointValue];
//                CGContextMoveToPoint(context, first.x, first.y);
//            }
//        } else {
//            CGContextMoveToPoint(context, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//        }    
//        if ([points count] > 4) {
//            for (int i = 0; i<[points count]-2; i+=3) {
//                CGPoint pt1 =  [[points objectAtIndex:i] CGPointValue];
//                CGPoint pt2 = [[points objectAtIndex:i+1] CGPointValue];
//                CGPoint pt3 = [[points objectAtIndex:i+2] CGPointValue];
//                  
//                CGContextAddCurveToPoint(context, pt1.x, pt1.y, pt2.x, pt2.y, pt3.x, pt3.y);
//
//    
//            }
//        }
//        // CGContextClosePath(context);
//        CGContextStrokePath(context);
//    }
//    
    
    
      
}

- (void) plotPoints : (CGRect) rect theContext: (CGContextRef) context {
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);
    CGContextSetRGBFillColor(context, 255,255,255,0.2);
    CGContextSetLineWidth(context, 2);
    for (int i=0; i<[points count]; i++) {
        NSValue *value = [points objectAtIndex:i];
        CGPoint p = [value CGPointValue];
        CGFloat x = p.x;
        CGFloat y = p.y;
        CGContextStrokeEllipseInRect(context, CGRectMake(x,y, 30,30));
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
    
    //    BOOL found = FALSE;
    //    for (int i=0; i<[points count]; i++) {
    //        NSValue *value = [points objectAtIndex:i];
    //        CGPoint p = [value CGPointValue];
    //        CGFloat dist = [self pDist : p point2: point];
    //        if (dist <= FILTER_TOUCH_RADIUS) {
    ////            [points insertObject:[NSValue valueWithCGPoint:point atIndex:i]];
    //            //[points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:a]]; 
    //            found = TRUE;
    //            break;
    //        }
    //        
    //    }
    
    if ([points count] > 2) {
        
        float lastDist = FLT_MAX;
        bool foundit = false;
        int myIndex = 0;
        for (int i=0; i<[points count]; i++) {
            //CGFloat dist = [self xDist : point point2: [[points objectAtIndex:i] CGPointValue]];
            
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
- (void) clearStrokes : (id) sender {
    [self clearAllStrokes];	
}

- (void) clearAllStrokes {
    [points removeAllObjects];
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
//       [self isFirstResponder];
         points = [[NSMutableArray alloc] init];
        CGPoint a = CGPointMake(0.0, self.frame.size.height/2.0);
        CGPoint c = CGPointMake(self.frame.size.width/4.0, self.frame.size.height/4.0);
        CGPoint b = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
        CGPoint d = CGPointMake(3*self.frame.size.width/4.0, self.frame.size.height/4.0);
        CGPoint e = CGPointMake(self.frame.size.width, self.frame.size.height/2.0);
        
        [points addObject:[NSValue valueWithCGPoint:a]];
        [points addObject:[NSValue valueWithCGPoint:b]];
        [points addObject:[NSValue valueWithCGPoint:c]];
        [points addObject:[NSValue valueWithCGPoint:d]];
        [points addObject:[NSValue valueWithCGPoint:e]];
    }
    return self;
}


//- (BOOL)canBecomeFirstResponder {
//    return YES;
//}
//
//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {}
//
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    
//    if (event.subtype == UIEventSubtypeMotionShake) {
//        
//        NSLog(@"shakened acknowledged\n");
//        [self clearAllStrokes];
//        [self setNeedsDisplay];
//    }
//    
//}

- (void)dealloc {
    [points release];
    [super dealloc];
}




@end
