
#import <UIKit/UIKit.h>

@interface DrawingView : UIView
{
    void *data;
    CGContextRef context;
}
-(void)clear;
-(void)toggleColor:(BOOL)isBlack;
-(void)setLineWidth:(CGFloat)width;
-(UIImage *)UIImage;

@end
