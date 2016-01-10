//
//  ViewController.m
//  Lesson 23 HW 2
//
//  Created by Alex on 10.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView* viewBoxer;
@property (strong, nonatomic) NSMutableArray* arrayBoxer;
@property (assign,nonatomic) CGFloat globalViewScale;
@property (assign,nonatomic) CGFloat globalViewRotation;

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
    
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired =2;
    [self.view addGestureRecognizer:doubleTapGesture];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    UISwipeGestureRecognizer* leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer* rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    UIRotationGestureRecognizer* rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
    
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
    
    [self rotationView:self.viewBoxer rotationAngel:-3.14];
    [self rotationView:self.viewBoxer rotationAngel:-3.14];
    
}


- (void) handleRightSwipe:(UISwipeGestureRecognizer*) rightSwipeGesture {
    
    [self rotationView:self.viewBoxer rotationAngel:3.14];
    [self rotationView:self.viewBoxer rotationAngel:3.14];
    
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

- (void) handleDoubleTap:(UITapGestureRecognizer*) tapGesture {
    [self.viewBoxer.layer removeAllAnimations];
    [self.viewBoxer startAnimating];
}


- (void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.globalViewScale =1.f;
    }
    
    CGFloat newScale = 1.f + pinchGesture.scale - self.globalViewScale;
    CGAffineTransform currentTransform = self.viewBoxer.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.viewBoxer.transform = newTransform;
    self.globalViewScale = pinchGesture.scale;
}

- (void) handleRotation:(UIRotationGestureRecognizer*) rotationGesture {
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.globalViewRotation =0;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.globalViewRotation;
    CGAffineTransform currentTransform = self.viewBoxer.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    self.viewBoxer.transform = newTransform;
    self.globalViewRotation = rotationGesture.rotation;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
