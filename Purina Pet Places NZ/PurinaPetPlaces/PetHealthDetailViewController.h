//
//  PetHealthDetailViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-19.
//
//

#import "ParentViewController.h"
#import "PieChatView.h"

@interface PetHealthDetailViewController : ParentViewController<actionDelegate>


@property (nonatomic, strong) PieChatView *pieview;
@end
