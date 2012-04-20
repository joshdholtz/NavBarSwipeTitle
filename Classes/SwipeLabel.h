//
//  SwipeLabel.h
//  NavBarTitleSwipe
//
//  Created by Josh Holtz on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipeLabelDelegate <NSObject>

- (void) swipeLabelChanged:(NSInteger)index withText:(NSString*)text;

@end

@interface SwipeLabel : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<SwipeLabelDelegate> delegate;
@property (nonatomic, strong) NSArray *options;

- (id)initWithFrame:(CGRect)frame withOptions:(NSArray*)options;

@end
