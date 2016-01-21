//
//  ViewController.m
//  FastestRPM
//
//  Created by Anthony Tulai on 2016-01-21.
//  Copyright © 2016 Anthony Tulai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *needle;

@property (assign) float needleSpeed;
@property (assign) float maxSpeed;
@property (assign) float needleLocation;
@property (strong, nonatomic) IBOutlet UILabel *maxSpeedLabel;


@end

@implementation ViewController
- (IBAction)panGestureRecongizer:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        
        
        NSString *maxSpeedString = @"";
        NSNumber *maxSpeedNumber = @(0);
        CGFloat velocityX = [sender velocityInView:self.view].x;
        
        CGFloat velocityY = [sender velocityInView:self.view].y;
        
        self.needleSpeed = sqrt(velocityX*velocityX + velocityY*velocityY);
        
        if (self.needleSpeed > self.maxSpeed) {
            self.maxSpeed = self.needleSpeed;
        }
        
        if (self.needleSpeed > 6000.0) {
            self.needleSpeed = 6000.0;
        }
        
        self.needleLocation = self.needleSpeed / 21.58 + 137;
        

        
        [UIView animateWithDuration:0.5 animations:^{
            self.needle.transform = CGAffineTransformMakeRotation(self.needleLocation * M_PI/180);
        }];
        //[UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //} completion:^ (BOOL completed) {}         ];
        
        maxSpeedNumber = @(self.maxSpeed);
        maxSpeedString = [maxSpeedNumber stringValue ];
        self.maxSpeedLabel.text = [@"Max Speed (p/s): " stringByAppendingString:maxSpeedString];
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.needle.transform = CGAffineTransformMakeRotation(137.0 * M_PI/180);
    }
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maxSpeed = 3.0;
    self.needle.transform = CGAffineTransformMakeRotation(137.0 * M_PI/180);
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
