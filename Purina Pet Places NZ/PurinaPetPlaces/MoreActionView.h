//
//  MoreActionView.h
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/10.
//
//

#import <UIKit/UIKit.h>

@protocol transformBoolDelegate <NSObject>

- (void)clickPieWithBool:(BOOL)nowBool;

@end



@interface MoreActionView : UIView

@property(nonatomic,strong)UILabel *propmtLab;
@property(nonatomic,strong)UIView *darkView;

@property (nonatomic, weak)id<transformBoolDelegate>delegate;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,strong)UIButton *yesBtn;
@property(nonatomic,strong)UIButton *noBtn;

@end
