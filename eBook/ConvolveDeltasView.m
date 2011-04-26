//
//  ConvolveDeltas.m
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "ConvolveDeltasView.h"
#import "DiscreteSignal.h"
#import "Delta.h"
#import "Axis.h"

#define FILTER_TOUCH_RADIUS 50

#define GRIDSTEP 50

#define ortho(x) ((int)(((float)x)/((float)GRIDSTEP)))*GRIDSTEP

@implementation ConvolveDeltasView

@synthesize signal;


- (void) drawRect : (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    // draw grid lines
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.225);
    CGContextSetLineWidth(context, 1);

    // axis
    [axis draw:context];
    
    // draw axes
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.5);
    CGContextSetLineWidth(context, 4);

    
    // NOT SURE WHY THIS WORKS!! if you split views horizontally, this will suffice for now
    CGRect r = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
    [axis drawAxis:context rect:r];
    
    CGContextSetRGBStrokeColor(context, 255, 255, 255, 1);
    CGContextSetLineWidth(context, 6);
    
    //dots
    
    for (int i=0; i<[signal.points count]; i++) {
        NSValue *value = [signal.points objectAtIndex:i];
        CGPoint p = [value CGPointValue];
 
        CGFloat y = self.frame.size.height/2.0;

        Delta * delta = [[Delta alloc] initWithPointsA:CGPointMake(p.x, y) B:CGPointMake(p.x, p.y)]; 
        [delta draw:context];
        [delta release];
        
    }

}

- (float) pDist : (CGPoint) a point2: (CGPoint) b {
    float x = a.x - b.x;
    float y = a.y - b.y;
    return sqrt(x*x + y*y);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for(UITouch *t in touches) {
        CGPoint theTouch = [t locationInView:self];
        theTouch.x = ortho(theTouch.x);
        for (int i=0; i<[signal.points count]; i++) {
            if (theTouch.x == [[signal.points objectAtIndex:i] CGPointValue].x) {
                if([t tapCount] == 2) {
                    theTouch.y = self.frame.size.height/2.0;
                } 
                [signal.points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:theTouch]];     
                break;
            } 
        }        
    }
}




- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for(UITouch *t in touches) {
        CGPoint a = [t locationInView:self];
        a.x = ortho(a.x);
        for (int i=0; i<[signal.points count]; i++) {
            NSValue *value = [signal.points objectAtIndex:i];
            CGPoint p = [value CGPointValue];
            if (p.x == a.x) {
                [signal.points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:a]];              
                break;
            }
            
        }
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}


- (void) clearAll {
    [signal.points removeAllObjects];
    [self setNeedsDisplay];
    
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-55   , [[UIScreen mainScreen] bounds].size.width, 100)];
        [toolbar sizeToFit];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        
        
        UIBarButtonItem* buttonItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonSystemItemAction target:self action:@selector(clearAll)];
        
        [toolbar setItems:[NSArray arrayWithObjects:buttonItem1, nil]];
        
        [buttonItem1 release];
        
        
        [self addSubview:toolbar];
        [toolbar release];

        axis = [[Axis alloc] initWithSpacingX:GRIDSTEP Y:GRIDSTEP];
        
        signal = [[DiscreteSignal alloc] init];
        signal.base = self.frame.size.height/2.0;        
        
        for(int i=self.frame.origin.x; i<self.frame.origin.x+self.frame.size.width; i+=GRIDSTEP) {
            [signal.points addObject:[NSValue valueWithCGPoint:CGPointMake(i, self.frame.size.height/2.0)]];
        }
        
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
    [signal release];
}




@end
