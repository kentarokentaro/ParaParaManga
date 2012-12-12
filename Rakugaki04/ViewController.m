//
//  ViewController.m
//  Rakugaki04
//
//  Created by kentaro_miura on 12/12/04.
//  Copyright (c) 2012年 kentaro_miura. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self calltoolbar];
    [self sliderSet];
    //キャンバス生成
    canvas = [[UIImageView alloc] initWithImage:nil];
    canvas.backgroundColor= [UIColor whiteColor];
    canvas.frame = self.view.frame;
    [self.view insertSubview:canvas atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチ開始座標をインスタンス変数touchPointに保持
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:canvas];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 現在のタッチ座標をローカル変数currentPointに保持
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:canvas];
    
    // 描画領域をcanvasの大きさで生成
    UIGraphicsBeginImageContext(canvas.frame.size);
    
    // canvasにセットされている画像（UIImage）を描画
    [canvas.image drawInRect:
     CGRectMake(0, 0, canvas.frame.size.width, canvas.frame.size.height)];
    
    // 線の角を丸くする
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    // 線の太さを指定
    CGContextSetLineWidth (UIGraphicsGetCurrentContext(), 10.0);
    
    // 線の色を指定（RGB）
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    
    // 線の描画開始座標をセット
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x, touchPoint.y);
    
    // 線の描画終了座標をセット
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    // 描画の開始～終了座標まで線を引く
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    // 描画領域を画像（UIImage）としてcanvasにセット
    canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 描画領域のクリア
    UIGraphicsEndImageContext();
    
    // 現在のタッチ座標を次の開始座標にセット
    touchPoint = currentPoint;
}


#pragma mark toolbar & barbutton
-(void)calltoolbar
{
    //toolbar生成
    UIToolbar *tlBar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)]autorelease];
    [tlBar setTintColor:[UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:1.0]];
    
    //ツールバー登録用ボタン配列
    NSMutableArray *barBtns = [[NSMutableArray alloc] init];
    
    // ペンボタンの生成
    UIBarButtonItem *penBtn =   [
                                 [UIBarButtonItem alloc]
                                 initWithTitle:@"ペン"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(pen)
                                 ];
    // カラーボタンの生成
    UIBarButtonItem *colorBtn = [
                                 [UIBarButtonItem alloc]
                                 initWithTitle:@"カラー"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(color)
                                 ];
    
    // 背景ボタンの生成
    UIBarButtonItem *bgBtn =    [
                                 [UIBarButtonItem alloc]
                                 initWithTitle:@"背景"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(bg)
                                 ];
    
    // クリアボタンの生成
    UIBarButtonItem *clearBtn = [
                                 [UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                 target:self
                                 action:@selector(clear:)
                                 ];
    // スタンプボタンの生成
    UIBarButtonItem *stampBtn = [
                                 [UIBarButtonItem alloc]
                                 initWithTitle:@"スタンプ"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(stamp)
                                 ];
    // 間隔用ボタンの生成
    UIBarButtonItem *spaceBtn = [
                                 [UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                 target:self
                                 action:nil
                                 ];
    // ツールバーにセット
    [barBtns addObject:spaceBtn];
    [barBtns addObject:penBtn];
    [barBtns addObject:spaceBtn];
    [barBtns addObject:bgBtn];
    [barBtns addObject:spaceBtn];
    [barBtns addObject:colorBtn];
    [barBtns addObject:spaceBtn];
    [barBtns addObject:stampBtn];
    [barBtns addObject:spaceBtn];
    [barBtns addObject:clearBtn];
    [barBtns addObject:spaceBtn];
    
    [tlBar setItems:barBtns animated:YES];
    
    [barBtns release];
    [spaceBtn release];
    [clearBtn release];
    [bgBtn release];
    [colorBtn release];
    [stampBtn release];
    
    [self.view addSubview:tlBar];
}

-(void)clear:(id)sender
{
    NSLog(@"画像を消去");
    canvas.image = nil;
}

-(void)pen
{
    NSLog(@"ペンツール");
}

-(void)color
{
    NSLog(@"色を指定");
}

-(void)bg
{
    NSLog(@"背景");
}

-(void)stamp
{
    NSLog(@"スタンプ用意したいな");
}

#pragma mark slider
-(void)sliderSet
{
    // スライダー作成
    UISlider *linesl = [[[UISlider alloc] initWithFrame:CGRectMake(0, 400, 200, 60)]
                    autorelease];
    [linesl addTarget:self action:@selector(changeSlider:)
 forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:linesl];
    
    // スライダーの値表示用ラベル作成
    m_lbl = [[[UILabel alloc] initWithFrame:CGRectMake(220, 400, 320, 60)]
             autorelease];
    // スライダーの値をラベルに設定する
    [m_lbl setText:[NSString stringWithFormat:@"%f", [linesl value]]];
    [self.view addSubview:m_lbl];

}
-(void)changeSlider:(UISlider*)sender
{
    // スライダーの値をラベルに設定する
    [m_lbl setText:[NSString stringWithFormat:@"%f", [sender value]]];
    
}


@end
