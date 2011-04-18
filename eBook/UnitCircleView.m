//
//  UnitCircleView.m
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "UnitCircleView.h"


#define FILTER_TOUCH_RADIUS 50


@implementation UnitCircleView



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
    CGContextSetRGBStrokeColor(context, 255, 255, 255, 0.4);
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
            
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 1.0, 1);
    CGContextSetLineWidth(context, 2);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x, y);
    CGContextAddLineToPoint(context, x, y);
    CGContextAddLineToPoint(context, xx, yy);  
    CGContextStrokePath(context);
    
    
    
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 1.0, 1);    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x, y);
    CGContextAddLineToPoint(context, x, y);
    CGContextAddLineToPoint(context, xx, y);    

    CGContextMoveToPoint(context, x, y);
    CGContextAddLineToPoint(context, x, y);
    CGContextAddLineToPoint(context, x, yy);    
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
    
    CGContextSetRGBFillColor(context, 0.0,1.0,1.0,1);
    CGContextSetLineWidth(context, 3);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint( context , ax , ay );
    CGContextAddLineToPoint( context , bx , by );
    CGContextAddLineToPoint( context , cx , cy );
    CGContextFillPath(context);
    
      
     
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
//        
//        UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-155, [[UIScreen mainScreen] bounds].size.width, 100)];
//        [toolbar sizeToFit];
//        toolbar.barStyle = UIBarStyleBlackTranslucent;
//        
//        
//        UIBarButtonItem* buttonItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonSystemItemAction target:self action:@selector(clearAll)];
//        UIBarButtonItem* buttonItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Poles" style:UIBarButtonSystemItemAction target:self action:@selector(addPoles)];
//        UIBarButtonItem* buttonItem3 = [[UIBarButtonItem alloc] initWithTitle:@"Zeros" style:UIBarButtonSystemItemAction target:self action:@selector(addZeros)];
//        UIBarButtonItem* buttonItem4 = [[UIBarButtonItem alloc] initWithTitle:@"Toggle Vectors" style:UIBarButtonSystemItemAction target:self action:@selector(vectorDisplay)];
//
//        [toolbar setItems:[NSArray arrayWithObjects:buttonItem1, buttonItem2, buttonItem3, buttonItem4, nil]];
//        
//        [buttonItem1 release];
//        [buttonItem2 release];
//        [buttonItem3 release];
//        [buttonItem4 release];
//
//        
//        [self addSubview:toolbar];
//        [toolbar release];

    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}




@end
