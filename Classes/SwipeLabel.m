//
//  SwipeLabel.m
//  NavBarTitleSwipe
//
//  Created by Josh Holtz on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SwipeLabel.h"

@interface SwipeLabel()

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation SwipeLabel

@synthesize swipeLeft = _swipeLeft;
@synthesize swipeRight = _swipeRight;
@synthesize tap = _tap;

@synthesize currentIndex = _currentIndex;

@synthesize delegate = _delegate;
@synthesize options = _options;

- (id)initWithFrame:(CGRect)frame withOptions:(NSArray*)options
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setClipsToBounds:YES];
        
        _options = options;
        _currentIndex = 0;
        [self addSubview:[_options objectAtIndex:_currentIndex]];
        
        [self setUserInteractionEnabled:YES];
        
        /*
         * Enables swipe left to collapse.
         */
        _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognitionSwipeLeft:)];
        [_swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:_swipeLeft];
        
        /*
         * Enables swipe right to collapse.
         */
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognitionSwipeRight:)];
        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:_swipeRight];
        
        /*
         * Enables tapd.
         */
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognitionTap:)];
        [self addGestureRecognizer:_tap];
        
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return NO;
}

- (void)swipeRecognitionSwipeLeft:(UISwipeGestureRecognizer*)sender {
    NSLog(@"Swipe left");
    
    UILabel *outLabel = [_options objectAtIndex:_currentIndex];
    
    _currentIndex = (_currentIndex == 0 ? ([_options count] - 1) : (_currentIndex - 1));
     UILabel *inLabel = [_options objectAtIndex:_currentIndex];
    inLabel.frame = CGRectMake(outLabel.frame.size.width, 0, outLabel.frame.size.width, outLabel.frame.size.height);
    inLabel.alpha = 0;
    [self addSubview:inLabel];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        outLabel.frame = CGRectMake(-1*(outLabel.frame.size.width), 0, outLabel.frame.size.width, outLabel.frame.size.height);
        outLabel.alpha = 0;
        inLabel.frame = CGRectMake(0, 0, inLabel.frame.size.width, inLabel.frame.size.height);
        inLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [outLabel removeFromSuperview];
        
        if ([_delegate respondsToSelector:@selector(swipeLabelChanged:withText:)]) {
            [_delegate swipeLabelChanged:_currentIndex withText:inLabel.text];
        }
        
    }];
}

- (void)swipeRecognitionSwipeRight:(UISwipeGestureRecognizer*)sender {
    NSLog(@"Swipe right");
    
    UILabel *outLabel = [_options objectAtIndex:_currentIndex];
    
    _currentIndex = (_currentIndex == [_options count] - 1 ? 0 : (_currentIndex + 1));
    UILabel *inLabel = [_options objectAtIndex:_currentIndex];
    inLabel.frame = CGRectMake(-1*(outLabel.frame.size.width), 0, outLabel.frame.size.width, outLabel.frame.size.height);
    inLabel.alpha = 0;
    [self addSubview:inLabel];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        outLabel.frame = CGRectMake(outLabel.frame.size.width, 0, outLabel.frame.size.width, outLabel.frame.size.height);
        outLabel.alpha = 0;
        inLabel.frame = CGRectMake(0, 0, inLabel.frame.size.width, inLabel.frame.size.height);
        inLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [outLabel removeFromSuperview];
        
        if ([_delegate respondsToSelector:@selector(swipeLabelChanged:withText:)]) {
            [_delegate swipeLabelChanged:_currentIndex withText:inLabel.text];
        }
        
    }];
}

- (void)swipeRecognitionTap:(UITapGestureRecognizer*)sender {
    NSLog(@"Tap - %@", [[sender.view class] description]);
}

#pragma mark - Transitions

//- (void)fadeOut:(NSString*)newText {
//    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationCurveEaseIn animations:^{
//        self.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self setText:newText];
//        [self fadeIn];
//    }];
//}
//
//- (void)fadeIn {
//    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationCurveEaseIn animations:^{
//        self.alpha = 1;
//    } completion:^(BOOL finished) {
//        
//    }];
//}

@end
