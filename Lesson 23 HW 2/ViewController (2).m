//
//  ViewController.m
//  Lesson 23 HW 2
//
//  Created by Alex on 10.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView* viewBoxer;
@property (strong, nonatomic) NSMutableArray* arrayBoxer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.arrayBoxer = [[NSMutableArray alloc] init];
    self.viewBoxer = [[UIImageView alloc] initWithFrame:CGRectMake(120, 250, 150, 170)];
    self.viewBoxer.backgroundColor = [UIColor clearColor];
    
    // All copyrites to images belong to Blizzard
    for (int i=1; i<12; i++) {
        NSString* zeroString = [NSString stringWithFormat:@"%d",i];
        NSString* firstString = @".jpg";
        NSString* nameOfFile = [zeroString stringByAppendingString:firstString];
        UIImage* i = [UIImage imageNamed:nameOfFile];
        [self.arrayBoxer addObject:i];
    }
    
    self.viewBoxer.animationImages = self.arrayBoxer;
    self.viewBoxer.animationDuration = 0.7f;
    [self.viewBoxer startAnimating];
    
    [self.view addSubview:self.viewBoxer];
    
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer* leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer* rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
}

#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    NSLog(@"handleTap");
    
    
    
    [UIView animateWithDuration:2.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear  | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                            self.viewBoxer.center = [tapGesture locationInView:self.view];
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void) handleLeftSwipe:(UISwipeGestureRecognizer*) leftSwipeGesture {
    
    [self rotationView:self.viewBoxer rotationAngel:-3.14159265358979323846264338327950288];
    
}


- (void) handleRightSwipe:(UISwipeGestureRecognizer*) rightSwipeGesture {
    
    [self rotationView:self.viewBoxer rotationAngel:3.14159265358979323846264338327950288];
    
}



- (void) rotationView: (UIView*) viewRotate rotationAngel: (CGFloat) angleRotate {
    CGAffineTransform currentTransform = viewRotate.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, angleRotate);
    [UIView animateKeyframesWithDuration:5.0
                                   delay:0
                                 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                              animations:^{
                                  viewRotate.transform = newTransform;
                              } completion:^(BOOL finished) {
                               
                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
