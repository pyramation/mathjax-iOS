//
//  UnitCircleView.m
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "UnitCircleView.h"
#import "Vec2.h"

#define FILTER_TOUCH_RADIUS 50

#import "Axis.h"

@implementation UnitCircleView
@synthesize axis, angleLabel;

- (void) drawRect : (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    [axis draw:context];

    // draw unit circle
    CGContextSetRGBStrokeColor(context, 255, 255, 255, 0.4);
    CGContextSetLineWidth(context, 4);
    CGFloat x = self.frame.size.width/2.0 + self.frame.origin.x;
    CGFloat y = self.frame.size.height/2.0 + self.frame.origin.y;  
    
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

    CGContextSetLineWidth(context, 6);
    
    CGFloat s = (self.frame.size.width < self.frame.size.height) ? self.frame.size.width : self.frame.size.height;
    s *= 0.95;
    float subS = s/2.0;
    x -= subS;
    y -= subS;    
    CGRect f = CGRectMake(x, y, s,s);
    CGContextStrokeEllipseInRect(context, f);

    
    //dots
    x = self.frame.size.width/2.0;
    y = self.frame.size.height/2.0;
        

    float xx = lastTouch.x;
    float yy = lastTouch.y;
            
    // draw the vector 
    Vec2 * vec = [[Vec2 alloc] initWithPointsA:CGPointMake(x, y) B:CGPointMake(xx, yy)];
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 1.0, 1);
    CGContextSetRGBFillColor(context, 0.0,1.0,1.0,1);
    [vec draw:context];
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 1.0, 1);    
    [vec drawComponents:context];
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);    
    [vec drawTrigComponents:context];
    NSString * str = [[NSString alloc] initWithFormat:@"%f", [vec angle]];
    angleLabel.text = str;
    [str release];
    [vec release];      
     
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for(UITouch *t in touches) {
        lastTouch = [t locationInView:self];        
    }

}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch *t in touches) {
        lastTouch = [t locationInView:self];        
    }
    [self setNeedsDisplay];
 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        axis = [[Axis alloc] init];
        angleLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x+50, frame.origin.y+60, 100, 50)];
        angleLabel.text = @"0";
        angleLabel.textColor = [UIColor redColor];
        angleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:angleLabel];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    [axis release];
    [angleLabel release];
}




@end
