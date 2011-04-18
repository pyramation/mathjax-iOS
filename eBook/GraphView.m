//
//  GraphView.m
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "GraphView.h"


#define FILTER_TOUCH_RADIUS 50


@implementation GraphView
@synthesize freq;


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

    // draw axes
    CGContextSetRGBStrokeColor(context, 1,1,1, 1);
    CGContextSetLineWidth(context, 4);

    
    CGFloat y = self.frame.size.height/2.0 + self.frame.origin.y;  

    // limits of int
    CGContextSetRGBFillColor(context, 0,1,0, 0.5);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, lLimit.x, y);
    CGContextTranslateCTM(context, self.frame.size.width/2.0, self.frame.size.height/2.0);
    CGContextMoveToPoint(context, lLimit.x-self.frame.size.width/2.0,0);
    float i;
    for(i=lLimit.x-self.frame.size.width/2.0; i<rLimit.x-self.frame.size.width/2.0; i+=0.1) {
        CGContextAddLineToPoint(context, i, -300*sin(i/freq)/(i/freq));
    }
    CGContextAddLineToPoint(context, i, 0);
    CGContextFillPath(context);
    CGContextTranslateCTM(context, -self.frame.size.width/2.0, -self.frame.size.height/2.0);

    
    //  stroke graph    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width, y);
    CGContextAddLineToPoint(context, self.frame.size.width, y);
    CGContextAddLineToPoint(context, 0, y);    
    CGContextStrokePath(context);

    CGContextSetRGBStrokeColor(context, 1,1,1, 1);
    CGContextBeginPath(context);
    CGContextTranslateCTM(context, self.frame.size.width/2.0, self.frame.size.height/2.0);
    CGContextMoveToPoint(context, -self.frame.size.width/2.0,0);
    for(float i=-self.frame.size.width/2.0; i<self.frame.size.width/2.0; i+=0.1) {
        CGContextAddLineToPoint(context, i, -300*sin(i/freq)/(i/freq));
    }
    CGContextStrokePath(context);
    CGContextTranslateCTM(context, -self.frame.size.width/2.0, -self.frame.size.height/2.0);
    
    
    
   
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        freq = 100.0;
        
        CGRect frame = CGRectMake(0.0, 700, 200.0, 10.0);
        UISlider *slider = [[UISlider alloc] initWithFrame:frame];
        [slider addTarget:self action:@selector(changeFreq:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.minimumValue = 1.0;
        slider.maximumValue = 100.0;
        slider.continuous = YES;
        slider.value = 25.0;
        
        [self addSubview:slider];
        
        
        // limits
        lLimit.x = self.frame.origin.x;
        rLimit.x = self.frame.size.width;
       
    }
    return self;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for(UITouch *t in touches) {
        CGPoint theTouch = [t locationInView:self];
        
        float distR = (theTouch.x - rLimit.x)*(theTouch.x - rLimit.x);
        float distL = (theTouch.x - lLimit.x)*(theTouch.x - lLimit.x);
      
        if (distL < distR) lLimit.x = theTouch.x;
        else rLimit.x = theTouch.x;

        if (rLimit.x < lLimit.x) {
            int a = rLimit.x;
            rLimit.x = lLimit.x;
            lLimit.x = a;
        }

    
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for(UITouch *t in touches) {
        CGPoint theTouch = [t locationInView:self];
        
        float distR = (theTouch.x - rLimit.x)*(theTouch.x - rLimit.x);
        float distL = (theTouch.x - lLimit.x)*(theTouch.x - lLimit.x);
        
        if (distL < distR) lLimit.x = theTouch.x;
        else rLimit.x = theTouch.x;
        
        if (rLimit.x < lLimit.x) {
            int a = rLimit.x;
            rLimit.x = lLimit.x;
            lLimit.x = a;
        }
        
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}

- (void) changeFreq:(id) sender {
    
    UISlider * slider = (UISlider *) sender;    
    freq = slider.value;
    
    [self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}




@end
