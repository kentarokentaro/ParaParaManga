//
//  ViewController.h
//  Rakugaki04
//
//  Created by kentaro_miura on 12/12/04.
//  Copyright (c) 2012年 kentaro_miura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UILabel *m_lbl; // スライダーの値表示用ラベル
    UIImageView *canvas;
    CGPoint touchPoint;
}

@end
