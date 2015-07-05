//
//  PieChatView.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-5-1.
//
//

#import <UIKit/UIKit.h>

#import "MoreActionView.h"
#import "GrobleSingleton.h"


#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI)) //弧度转化为角度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI) //角度转化为弧度


@protocol actionDelegate <NSObject>

- (void)transformIndex:(NSInteger)index;

@end

@interface PieChatView : UIView<transformBoolDelegate>{
    UIWindow *_uiWindow;
}


@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) NSMutableArray *cloves;
@property CGAffineTransform startTransform;
@property CGPoint wheelCenter;
@property (nonatomic, strong) NSMutableArray *pie;

@property (nonatomic, assign)id<actionDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withNum:(int)num withArray:(NSMutableArray *)array;
- (void)initWheel;
- (void) buildClovesOdd;
- (float) calculateDistanceFromCenter:(CGPoint)point;

@end
