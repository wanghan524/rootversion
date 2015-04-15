//
//  SearchView.m
//  PurinaPetPlaces
//
//  Created by art_kernel_zyc on 15/4/14.
//
//

#import "MySearchView.h"

@implementation MySearchView
{
    NSMutableArray *_btnArr;
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
//        [self makeCateGoryTable];
        _btnArr = [[NSMutableArray alloc]initWithCapacity:0];
        [self makeBtnClickTarget];
    }
    return self;
}



-(void)makeBtnClickTarget
{
    if(_btnArr == nil)
    {
        _btnArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    self.btnOne.tag = 10000;
    self.btnTwo.tag = 10001;
    self.btnThree.tag = 10002;
    [_btnArr addObject:self.btnOne];
    [_btnArr addObject:self.btnTwo];
    [_btnArr addObject:self.btnThree];
    
    for(UIButton *btn in _btnArr)
    {
        UIButton *tmpBtn = (UIButton *)btn;
        [tmpBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    
}

-(void)btnClick:(UIButton *)sender
{
    NSUInteger tagIndex = sender.tag;
    for(UIButton *btn in _btnArr)
    {
        [btn setBackgroundColor:[UIColor whiteColor]];
    }
    UIButton *tmpBtn = (UIButton *)[self viewWithTag:tagIndex];
    [tmpBtn setBackgroundColor:[UIColor redColor]];
    NSString *currentBtnStr = tmpBtn.titleLabel.text;
    self.currentDistanceStr = currentBtnStr;
    
}

-(void)layoutSubviews
{
    if(self.cateGoryTable == nil)
    {
//        [self makeCateGoryTable];
    }
    else
    {
        self.cateGoryTable.delegate = self;
        self.cateGoryTable.dataSource = self;
    }
    [self makeBtnClickTarget];
    self.searchTermTxt.delegate = self;
    self.suburbTxt.delegate = self;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.searchTermTxt.text isEqualToString:@""])
    {
        [self.searchTermTxt becomeFirstResponder];
        return NO;
    }
    if([self.suburbTxt.text isEqualToString:@""])
    {
        [self.suburbTxt becomeFirstResponder];
        return NO;
    }
    [textField resignFirstResponder];
    return YES;

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *touchView = [touch view];
    if(touchView == self)
    {
        [self.searchTermTxt resignFirstResponder];
        [self.suburbTxt resignFirstResponder];
    }
}


-(void)makeCateGoryTable
{
    self.cateGoryTable = [[UITableView alloc]initWithFrame:CGRectMake(self.cateGoryLabel.frame.origin.x,CGRectGetMaxY(self.cateGoryLabel.frame), self.cateGoryLabel.frame.size.width, 100) style:UITableViewStylePlain];
    self.cateGoryTable.delegate = self;
    self.cateGoryTable.dataSource = self;
    self.cateGoryTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.cateGoryTable];
    
}


- (IBAction)cateGoryBtnClick:(id)sender
{
    
    if(self.cateGoryTable == nil)
    {
        [self makeCateGoryTable];
        [self.cateGoryTable setHidden:NO];
        
    }
    else
    {
        BOOL isVisible = self.cateGoryTable.hidden;
        [self.cateGoryTable setHidden:!isVisible];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.cateGoryMuArr == nil)?0:([self.cateGoryMuArr count]);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cateGoryIden = @"cateGoryIden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cateGoryIden];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cateGoryIden];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = ((self.cateGoryMuArr == nil)?@"":[self.cateGoryMuArr objectAtIndex:indexPath.row]);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectStr = (self.cateGoryMuArr == nil)?@"":([self.cateGoryMuArr objectAtIndex:indexPath.row]);
    self.cateGoryLabel.text = selectStr;
    
}



@end
