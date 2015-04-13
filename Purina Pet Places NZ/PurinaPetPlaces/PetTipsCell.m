//
//  PetTipsCell.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 1/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PetTipsCell.h"

@implementation PetTipsCell
@synthesize tipTextLabel, tipTextLabelText, titleTextLabelText, titleTextLabel, rowNumber;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height)];
        //[bgView setBackgroundColor:[UIColor greenColor]];
        //[self addSubview:bgView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setTitleTextLabelText:(NSString *)s {
	titleTextLabelText = [s copy];
	[self setNeedsDisplay];
}

-(void)setRowNumber:(NSNumber *)s {
    rowNumber = [s copy];
    [self setNeedsDisplay];
}

-(void)setTipTextLabelText:(NSString *)s {
	tipTextLabelText = [s copy];
	[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect  {
    UIColor *backgroundColor = [[UIColor alloc] init] ;
    
    if ([rowNumber intValue] == 1)
        backgroundColor = [UIColor whiteColor];
    else
        backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [backgroundColor set];
    CGContextFillRect(context, rect);
    
    CGSize headingSize = [titleTextLabelText sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(260, 400) lineBreakMode:UILineBreakModeWordWrap];
    
    [titleTextLabel removeFromSuperview];
    titleTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 260, headingSize.height)];
    [titleTextLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleTextLabel setBackgroundColor:backgroundColor];
    [titleTextLabel setNumberOfLines:0];
    [titleTextLabel setLineBreakMode:UILineBreakModeWordWrap];
    [titleTextLabel setText:titleTextLabelText];
    [self addSubview:titleTextLabel];
    
    [tipTextLabel removeFromSuperview];
    tipTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20 + headingSize.height, 260, (rect.size.height - headingSize.height) - 35)];
    [tipTextLabel setTextColor:[UIColor blackColor]];
    [tipTextLabel setTextAlignment:UITextAlignmentLeft];
    [tipTextLabel setFont:[UIFont systemFontOfSize:14]];
    [tipTextLabel setText:tipTextLabelText];
    [tipTextLabel setNumberOfLines:0];
    [tipTextLabel setBackgroundColor:backgroundColor];
    [tipTextLabel setLineBreakMode:UILineBreakModeWordWrap];
    [self addSubview:tipTextLabel];
    

    
}
@end
