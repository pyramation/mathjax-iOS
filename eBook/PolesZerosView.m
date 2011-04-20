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
    
    [self drawPolesZeros:poles context:context x:x y:y poleOrZero:true];
    [self drawPolesZeros:zeros context:context x:x y:y poleOrZero:false];
}

- (void) drawPolesZeros:(NSMutableArray*) array context: (CGContextRef) context x:(float) x y: (float) y poleOrZero:(bool) poleOrZero {
    for (int i=0; i<[array count]; i++) {
        NSValue *value = [array objectAtIndex:i];
        CGPoint p = [value CGPointValue];
        CGFloat xx = p.x;
        CGFloat yy = p.y;
        
        CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);
        CGContextSetLineWidth(context, 4);
        if (!poleOrZero) CGContextStrokeEllipseInRect(context, CGRectMake(xx,yy, 30,30));
        else {
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, xx+20, yy+20);
            CGContextAddLineToPoint(context, xx+20, yy+20);
            CGContextAddLineToPoint(context, xx-20, yy-20);
            CGContextMoveToPoint(context, xx-20, yy+20);
            CGContextAddLineToPoint(context, xx+20, yy-20);
            CGContextStrokePath(context);
            
        }
  
        

        
        if (_vectors) {
            
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

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for(UITouch *t in touches) {
        if (![self onTouch:zeros touch:t]) {
            if (![self onTouch:poles touch:t]) [self addPoint:[t locationInView:self]];
        }        
    }
}

- (bool) onTouch: (NSMutableArray*) array touch:(UITouch*) t {
    CGPoint theTouch = [t locationInView:self];
    for (int i=0; i<[array count]; i++) {
        CGFloat dist = [self pDist : theTouch point2: [[array objectAtIndex:i] CGPointValue]];
        if (dist <= FILTER_TOUCH_RADIUS) {
            if([t tapCount] == 2) {
                [array removeObject:[array objectAtIndex:i]];
            } else {
                // 1 tap
                [array replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:theTouch]];     
            } 
            return true;
        } 
    }
    return false;

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
        for (int i=0; i<[poles count]; i++) {
            NSValue *value = [poles objectAtIndex:i];
            CGPoint p = [value CGPointValue];
            //CGFloat dist = [self pDist : a point2: p];
            CGFloat dist = [self pDist : a point2: p];
            if (dist <= FILTER_TOUCH_RADIUS) {
                
                [poles replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:a]];              
                [self setNeedsDisplay];
                return;
            }
            
        }
        for (int i=0; i<[zeros count]; i++) {
            NSValue *value = [zeros objectAtIndex:i];
            CGPoint p = [value CGPointValue];
            //CGFloat dist = [self pDist : a point2: p];
            CGFloat dist = [self pDist : a point2: p];
            if (dist <= FILTER_TOUCH_RADIUS) {
                
                [zeros replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:a]];              
                [self setNeedsDisplay];
                return;
            }
            
        }
    }
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}

- (void) addPoint : (CGPoint) point {

    
    if ([((_poles) ? poles : zeros) count] > 2) {
        
        float lastDist = FLT_MAX;
        bool foundit = false;
        int myIndex = 0;
        for (int i=0; i<[((_poles) ? poles : zeros) count]; i++) {
           
            float dist = [[((_poles) ? poles : zeros) objectAtIndex:i] CGPointValue].x - point.x;
            if (dist < 0) continue;
            if (dist <= lastDist) {
                foundit = true;
                lastDist = dist;
                myIndex = i;
            }
            
        }
        if (foundit) [((_poles) ? poles : zeros) insertObject:[NSValue valueWithCGPoint:point] atIndex:myIndex];
        else [((_poles) ? poles : zeros) addObject: [NSValue valueWithCGPoint: point]];
    } else {
        [((_poles) ? poles : zeros) addObject: [NSValue valueWithCGPoint: point]];
    }
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-55, [[UIScreen mainScreen] bounds].size.width, 100)];
        [toolbar sizeToFit];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        
        
        UIBarButtonItem* buttonItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonSystemItemAction target:self action:@selector(clearAll)];
        UIBarButtonItem* buttonItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Poles" style:UIBarButtonSystemItemAction target:self action:@selector(addPoles)];
        UIBarButtonItem* buttonItem3 = [[UIBarButtonItem alloc] initWithTitle:@"Zeros" style:UIBarButtonSystemItemAction target:self action:@selector(addZeros)];
        UIBarButtonItem* buttonItem4 = [[UIBarButtonItem alloc] initWithTitle:@"Toggle Vectors" style:UIBarButtonSystemItemAction target:self action:@selector(vectorDisplay)];

        [toolbar setItems:[NSArray arrayWithObjects:buttonItem1, buttonItem2, buttonItem3, buttonItem4, nil]];
        
        [buttonItem1 release];
        [buttonItem2 release];
        [buttonItem3 release];
        [buttonItem4 release];

        
        [self addSubview:toolbar];
        [toolbar release];
        
        _vectors = false;
        _poles = true;
        
        poles = [[NSMutableArray alloc] init];
        zeros = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) clearAll {
    [zeros removeAllObjects];
    [poles removeAllObjects];
    [self setNeedsDisplay];
}

- (void) vectorDisplay {
    _vectors = !_vectors;
    [self setNeedsDisplay];
}
- (void) addPoles {
    _poles = true;
}
- (void) addZeros {
    _poles = false;
}


- (void)dealloc {
    [zeros release];
    [poles release];
    [super dealloc];
}




@end
