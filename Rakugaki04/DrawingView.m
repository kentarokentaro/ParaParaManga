
#import "DrawingView.h"

@implementation DrawingView

-(id)initWithCoder:(NSCoder *)coder{
    if(self = [super initWithCoder:coder]){
        int width = self.bounds.size.width;
        int height = self.bounds.size.height;
        data = malloc(width * height * 4);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        context = CGBitmapContextCreate(data,width,height,8,4 * width,colorSpace,kCGImageAlphaPremultipliedFirst);
        CGColorSpaceRelease(colorSpace);
        
        [self clear];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextDrawImage(currentContext,rect,image);
    CGImageRelease(image);
}

-(void)clear
{
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, self.bounds);
    [self setNeedsDisplay];
}

-(void)toggleColor:(BOOL)isBlack
{
    if (isBlack) {
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    }else{
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    }
    
}

-(void)setLineWidth:(CGFloat)width
{
    CGContextSetLineWidth(context, width);
}

-(UIImage *)UIImage
{
    CGImageRef cgimage = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:cgimage];
    CGImageRelease(cgimage);
    return image;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint p = [[touches anyObject]locationInView:self];
    CGPoint q = [[touches anyObject]previousLocationInView:self];
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,q.x,q.y);
    CGContextAddLineToPoint(context,p.x,p.y);
    CGContextStrokePath(context);
    [self setNeedsDisplay];
}

-(void)dealloc{
    free(data);
    CGContextRelease(context);
    [super dealloc];
}

@end
