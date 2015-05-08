//
//  PieChatView.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-5-1.
//
//

#import "PieChatView.h"
#import <QuartzCore/QuartzCore.h>



@interface BptPieChart : UIView{

@private
    
    //Variables useful for drawing(用于绘图的有用变量) (Avoid recomputing them too much)(避免过多的验算)
    CGFloat centerX;
    CGFloat centerY;
    CGFloat radius;
    
    //Each element is an NSNumber representing a float
    //The values add up to 1.0
    NSMutableArray *slicePointsIn01;
    
    NSMutableArray *sliceNames;
    NSMutableArray *nameLabels;
    
    //Has BNColor elements. if #slices > #colors,the colors cycle.
    //When nil (default), uses autogennerated colors and never cycles;
    NSArray *colors;
    
    CGColorSpaceRef colorspace;//创建色彩空间对象
    
    int fontSize;
    
}
@property (nonatomic, strong) NSMutableArray *slicePortions;
@property (nonatomic, strong) NSArray *colors;




- (void)addSlicePortion:(float)slicePortion withName:(NSString *)name;

+ (BptPieChart *)pieChartSampleWithFrame:(CGRect)frame;

@end

#define KRadiusPortion 0.92
#define nFloat(x) [NSNumber numberWithFloat:x]

@interface BptPieChart ()

- (void)initInstance;
- (void)DrawSlice:(int)index inContext:(CGContextRef)context;
- (CGGradientRef)newGradientForIndex:(int)index;
- (void)addLabelForLastName:(int)index;
- (void)getRGBForIndex:(int)index red:(float *)red green:(float *)green blue:(float *)blue;
- (float)approxDistFromCenter:(CGRect)rect;
- (void)moveInLabel:(int)index;
- (void)movePreviousLabelIn;
- (float)pointAtIndex:(int)index;

@end


@implementation BptPieChart

@synthesize slicePortions,colors;


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initInstance];
        self.frame = frame;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initInstance];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    fontSize = frame.size.width / 20;
    if (fontSize < 9) {
        fontSize = 9;
    }
    
    centerX = frame.size.width / 2;
    centerY = frame.size.height / 2;
    radius = centerX < centerY ? centerX : centerY;
    radius *= KRadiusPortion;
    [self setNeedsDisplay];

}

- (void)addSlicePortion:(float)slicePortion withName:(NSString *)name{
    [sliceNames addObject:(name ? name : @"")];
    [slicePortions addObject:nFloat(slicePortion)];
    float sumSoFar = [self pointAtIndex:-1];
    [slicePointsIn01 addObject:nFloat(sumSoFar + slicePortion)];
}


- (void)drawRect:(CGRect)rect{
    
    if ([slicePortions count] == 0) {
        NSLog(@"%s -- called with no slicePortions data",__FUNCTION__);
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();//函数获取图形上下文的句柄
    CGContextBeginPath(context);//创建一条路径
    
    /*
     CGContextMoveToPoint(context,150,50);//圆弧的起始点
     
     CGContextAddArcToPoint(context,100,80,130,150,50);
     
     是说从（150，50）到（100，80）画一条线，然后再从（100，80）到（130，150）画一条线，从这两条线（无限延伸的） 和半径50可以确定一条弧，
     
     而
     
     CGContextAddArc(context, 100, 100, 30, 0, M_PI, 1);
     
     比较简单了，(100,100)为圆心的坐标，30为半径，（0，M_PI）为起始角度和结束角度，1为顺时针，0 为逆时针
     
     是说从（150，50）到（100，80）画一条线，然后再从（100，80）到（130，150）画一条线，从这两条线（无限延伸的） 和半径50可以确定一条弧
     
     */
    
    CGContextAddArc(context, centerX, centerY, radius, 0, 2 * M_PI, 1);
    
    /*
     填充颜色
     
     void CGContextSetRGBFillColor (
     
     CGContextRef c, //当前上下文
     
     CGFloat red,//r
     
     CGFloat green,//g
     
     CGFloat blue,//b
     
     CGFloat alpha//要注意的是这个是透明度oo
     
     );
     
     */
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    
    CGContextFillPath(context);//路径的填充，它的功能是用当前的填充颜色或样式填充路径线段包围的区域
    CGContextSaveGState(context);//函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会形象随后的描画操作，但是不想影响存储在堆栈的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形转态的快速方法，避免逐个车次奥所有的状态的修改，这也是将某些状态恢复到原有设置的唯一方式。
    
    CGContextBeginTransparencyLayer(context, NULL);//使用透明图层。直到相应的调用CGContextEndTransparencylayer,在制定范围内的所有后续绘制操作组合到一个完全透明的背景(它被视为一个单独的目标缓冲区从上下文)
    
    for (int i = 0 ; i < [slicePortions count]; i++) {
        [self DrawSlice:i inContext:context];
        [self addLabelForLastName:i];
    }
    
    CGContextEndTransparencyLayer(context);//使用全局alpha和阴影的上下文状态合成到上下文中
    CGContextRestoreGState(context);
    
}

- (void)initInstance{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.slicePortions = [NSMutableArray new];
    slicePointsIn01 = [[NSMutableArray alloc] initWithObjects:nFloat(0.0), nil];
    sliceNames = [NSMutableArray new];
    nameLabels = [NSMutableArray new];
    colorspace = CGColorSpaceCreateDeviceRGB();
}

- (void)DrawSlice:(int)index inContext:(CGContextRef)context{
    CGFloat startAngle = 2 * M_PI * [self pointAtIndex:index] - ((22.5) / 180.0 * M_PI);//开始的角度
    CGFloat endAngle = 2* M_PI * [self pointAtIndex:index + 1] - ((22.5) / 180.0 * M_PI);//结束的角度
    NSLog(@"startAngle : %f  endAngle: %f",RADIANS_TO_DEGREES(startAngle),RADIANS_TO_DEGREES(endAngle));
    CGMutablePathRef path = CGPathCreateMutable();//创建一个类型为CGMutablePathRef的可变路径，并返回其句柄。每次使用完这个路径，我们都应该为它做善后工作
    
    /*
     
     CGPathAddArc函数是通过圆心和半径定义一个圆，然后通过两个弧度确定一个弧线。注意弧度是以当前坐标环境的X轴开始的。
     
     需要注意的是由于iOS中的坐标体系是和Quartz坐标体系中Y轴相反的，所以iOS UIView在做Quartz绘图时，Y轴已经做了Scale为-1的转换，因此造成CGPathAddArc函数最后一个是否是顺时针的参数结果正好是相反的，也就是说如果设置最后的参数为YES，根据参数定义应该是顺时针的，但实际绘图结果会是逆时针的！
     
     
     CGContextAddArcToPoint:
     它是通过画两个虚拟的线来完成绘图的，这两条线是通过当前CGContextRef的点，和CGContextAddArcToPoint函数本身定义的两个点来完成的。而弧线会从当前CGContextRef的点开始，画到中心圆与第二条线的交点处。这样的画弧方式，在某些情况下可以使CGContextAddArcToPoint函数比CGPathAddArc用起来更加方便些
     */
    //CGAffineTransform transform = CGAffineTransformMakeRotation((22.5f * M_PI) / 180.0f);
    CGPathAddArc(path, NULL, centerX, centerY, radius, startAngle, endAngle, 0);
    CGPathAddLineToPoint(path,NULL, centerX, centerY);
    CGPathCloseSubpath(path);//关闭该path
    
    //Draw the shadowed slice (画弧形的阴影)
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    
    CGFloat red,green,blue;
    [self getRGBForIndex:index red:&red green:&green blue:&blue];
    CGContextSetRGBFillColor(context, red, green, blue, 0.35);//填充颜色
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    
    //Draw the left-right gradient(画左右边的渐变)
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);//使用非零绕数规则剪辑当前图形的上下文
    CGGradientRef grandient = [self newGradientForIndex:index];//用于封装Quarz绘制图形到输出设备的信息
    CGContextDrawLinearGradient(context, grandient, CGPointMake(centerX + radius, centerY), CGPointMake(centerX - radius, centerY), 0);//填充渐变色
    CGGradientRelease(grandient);
    CGContextRestoreGState(context);
    
    //Draw the slice outline (画轮廓)
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    
    CGContextClip(context);
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, 0.5);
    UIColor *darken = [UIColor colorWithWhite:0.0 alpha:0.2];
    CGContextSetStrokeColorWithColor(context, darken.CGColor);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGPathRelease(path);
    
}

#pragma mark - 添加标签
- (void)addLabelForLastName:(int)index{
    
    
    if ([[sliceNames lastObject] length] == 0) {
        [nameLabels addObject:[NSNull null]];
        return;
    }
    
    NSString* text = [sliceNames lastObject];
    CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:fontSize]];
    
    /*
     
     求一个扇形的重心一个扇形半径是R,角度是a,求它的重心是多少 （可以用微积分或几何）
     一个扇形半径是R,角度是a,求它的重心是多少 （可以用微积分或几何）
     
     首先重心一定再扇形角平分线上.角平分线长为r,设其中一段,从圆心出发,长为x.则有扇形面积为πr^2×a/360° 则由x形成的两个对称三角形面积和应为总面积的一半.即2×1/2sin(a/2)xr=1/2πr^2×a/360° 求的x=πra/720sin(a/2) 即在扇形角平分线上据圆心πra/720sin(a/2)的点位重心.
     
     */
    
    CGFloat startAngle1 = 2 * M_PI * [self pointAtIndex:0];
    
    CGFloat endAngle1 = 2* M_PI * [self pointAtIndex:1];
    
    CGFloat averageAngle1 = (startAngle1 + endAngle1) / 2.0;
    
    
    CGFloat startAngle = 2 * M_PI * [self pointAtIndex:index] - ((22.5) / 180.0 * M_PI);//开始的角度
    CGFloat endAngle = 2* M_PI * [self pointAtIndex:index + 1] - ((22.5) / 180.0 * M_PI);
    
    CGFloat averageAngle = (startAngle + endAngle) / 2.0;
    
    float radiusToAngle = RADIANS_TO_DEGREES(averageAngle);

    
    //计算出重心离远点的位置
    
    float distance;
    distance = (2 * radius * sinf(averageAngle1)) / (3 * averageAngle1);
    
    double distanceX,distanceY;
    
    distanceY = distance * sin(averageAngle);
    distanceX = distance * cos(averageAngle);
    
    //distance = (M_PI * radius * radiusToAngle) / (720 * sin(radiusToAngle / 2));
    NSLog(@"x : %lf  y: %lf ",distanceX,distanceY);
    
    double trueX,trueY;
    trueX = centerX + distanceX;
    trueY = centerY - distanceY;
    
    NSLog(@"trueX: %lf  trueY : %lf centerX : %lf centerY : %lf",trueX,trueY,centerX,centerY);
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(trueX - textSize.width / 2.0, trueY - textSize.height / 2.0,textSize.width, textSize.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    label.text = [NSString stringWithFormat:@"%d",index];
    [nameLabels addObject:label];
    [self addSubview:label];
    
    
#if 0
    
    if ([[sliceNames lastObject] length] == 0) {
        [nameLabels addObject:[NSNull null]];
        return;
    }
    
    NSString *text = [sliceNames lastObject];
    CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:fontSize]];
    
    //Find the angle of the relevant corners//从相关的角中找到角度
    
    float cornerDist[2] = {(self.frame.size.width - textSize.width) / 2,(self.frame.size.height - textSize.height) / 2};
    float cornerAngles[4];
    cornerAngles[0] = atan2(cornerDist[1], cornerDist[0]);
    cornerAngles[1] = M_PI - cornerAngles[0];
    cornerAngles[2] = cornerAngles[0] + M_PI;
    cornerAngles[3] = cornerAngles[1] + M_PI;
    
    //Find out which wall the center ray will hit
    int index = [slicePortions count] - 1;
    float rayAngle = ([self pointAtIndex:index] + [self pointAtIndex:(index + 1)]) * M_PI;
    int i;
    for ( i = 0; i< 4 && rayAngle > cornerAngles[i]; i++) {
        i = i % 4;
    }
    float hitPoint[2];
    float dist = (i % 2 == 0 ? cornerDist[0] : cornerDist[1]);
    
    if (i > 1) dist *= -1;
    hitPoint[i % 2] = dist;
    
    float delta[2] = {cos(rayAngle),sin(rayAngle)};
    float t = dist / delta[i % 2];
    hitPoint[1 - (i % 2)] = t * delta[1 - i % 2];
#endif
}

#pragma mark - 绘制渐变信息
- (CGGradientRef)newGradientForIndex:(int)index{
    size_t num_locations = 2;
    CGFloat location[2] = {0.0,1.0};
    CGFloat red,green,blue;
    [self getRGBForIndex:index red:&red green:&green blue:&blue];
    CGFloat components[8] = {red,green,blue,0.9,sqrt(red),sqrt(green),sqrt(blue),0.15};
    return CGGradientCreateWithColorComponents(colorspace, components, location, num_locations);
}


#pragma mark - 得到颜色值
- (void)getRGBForIndex:(int)index red:(float *)red green:(float *)green blue:(float *)blue{
    int i = 6 - index;
    *red = 0.5  + 0.5 *cos(i);
    *green = 0.5 + 0.5 * sin(i);
    *blue = 0.5 + 0.5 * cos(1.5 * i + M_PI / 4.0);
}

- (float)pointAtIndex:(int)index{
    index = (index + [slicePointsIn01 count]) % [slicePointsIn01 count];
    return  [(NSNumber *)[slicePointsIn01 objectAtIndex:index] floatValue];
}

@end




#pragma mark - Bpt Pie chart



static float deltaAngle;

@implementation PieChatView{
    CGFloat centerX;
    CGFloat centerY;
    CGFloat radius;
}
@synthesize startTransform,container,cloves,wheelCenter;
@synthesize pie;

- (id)initWithFrame:(CGRect)frame withNum:(int)num withArray:(NSMutableArray *)array{
    if (self == [super initWithFrame:frame]) {
        centerX = frame.size.width / 2;
        centerY = frame.size.height / 2;
        radius = centerX < centerY ? centerX : centerY;
        radius *= KRadiusPortion;
        
        cloves = [[NSMutableArray alloc] initWithCapacity:num];
        self.pie = array;
        [self initWheel];
    }
    return self;
}

- (void)initWheel{
    container = [[UIView alloc] initWithFrame:self.frame];
    
    BptPieChart *chart = [[BptPieChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    
    for (int i = 0 ; i < pie.count; i++) {
        NSString *slicePortion = [pie objectAtIndex:i];
        [chart addSlicePortion:[slicePortion floatValue] withName:slicePortion];
    }
    
    chart.layer.anchorPoint = CGPointMake(0.5f, 0.5f);//称为"定位点","锚点",决定着CALayer身上的哪个点会在position属性所指的位置，以自己的左上角为原点(0,0),它的x,y取值范围都是0~1,默认值为(0.5,0.5)
    
    chart.layer.position = CGPointMake(container.bounds.size.width / 2.0, container.bounds.size.height / 2.0);//用来设置CALayer在父层中的位置，以父层在左上角为原点(0,0)
    [container addSubview:chart];
    container.userInteractionEnabled = YES;
    [self addSubview:container];
}




#pragma mark - 
#pragma mark - 点击圆形区域
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint delta = [touch locationInView:self];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, centerX, centerY, radius, 0 ,2 * M_PI, 0);
    CGPathAddLineToPoint(path,NULL, centerX, centerY);
    CGPathCloseSubpath(path);//关闭该path
    
    if (CGPathContainsPoint(path, NULL, delta, NO)) {
        NSLog(@"包含这个点");
        
        //[self setNeedsDisplay];
        float distanceX = delta.x - centerX;
        float distanceY = centerY - delta.y;
        float xiebian = sqrtf(distanceX * distanceX + distanceY*distanceY);
        
        float radius1 = asin(distanceX / xiebian);
    
        float angle = RADIANS_TO_DEGREES(radius1);
        
        int index;
        
        //NSLog(@"angle : %lf",angle);
        if ((centerY - delta.y) > 0 ) {
            if(angle >= 67.5 && angle <= 90.0f){
                index = 0;
                NSLog(@"0");
            }
            else if (angle >= 22.5 && angle < 67.5){
                index = 7;
                NSLog(@"1");
            }
            else if (angle >= -22.5 && angle < 22.5){
                index = 6;
                NSLog(@"2");
            }
            else if (angle >= -67.5 && angle < -22.5){
                index = 5;
                NSLog(@"3");
            }
            else if (angle >= -90.0 && angle < -67.5){
                index = 4;
                NSLog(@"4");
            }
            
                
            
            
        }else{
            
            if(angle >= 67.5 && angle <= 90.0f){
                index = 0;
                NSLog(@"0");
            }
            else if (angle >= 22.5 && angle < 67.5){
                index = 1;
                NSLog(@"7");
            }
            else if (angle >= -22.5 && angle < 22.5){
                index = 2;
                NSLog(@"6");
            }
            else if (angle >= -67.5 && angle < -22.5){
                index = 3;
                NSLog(@"5");
            }
            else if (angle >= -90.0 && angle < -67.5){
                index = 4;
                NSLog(@"4");
            }
            
            
        }
        
        
        
        
        {
            UIGraphicsBeginImageContext(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64));
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGFloat startAngle = 2 * M_PI * index / 8 - ((22.5) / 180.0 * M_PI);//开始的角度
            CGFloat endAngle = 2* M_PI * (index + 1) / 8 - ((22.5) / 180.0 * M_PI);//结束的角度
            NSLog(@"startAngle : %f  endAngle: %f",RADIANS_TO_DEGREES(startAngle),RADIANS_TO_DEGREES(endAngle));
            CGMutablePathRef path = CGPathCreateMutable();//创建一个类型为CGMutablePathRef的可变路径，并返回其句柄。每次使用完这个路径，我们都应该为它做善后工作
            
            /*
             
             CGPathAddArc函数是通过圆心和半径定义一个圆，然后通过两个弧度确定一个弧线。注意弧度是以当前坐标环境的X轴开始的。
             
             需要注意的是由于iOS中的坐标体系是和Quartz坐标体系中Y轴相反的，所以iOS UIView在做Quartz绘图时，Y轴已经做了Scale为-1的转换，因此造成CGPathAddArc函数最后一个是否是顺时针的参数结果正好是相反的，也就是说如果设置最后的参数为YES，根据参数定义应该是顺时针的，但实际绘图结果会是逆时针的！
             
             
             CGContextAddArcToPoint:
             它是通过画两个虚拟的线来完成绘图的，这两条线是通过当前CGContextRef的点，和CGContextAddArcToPoint函数本身定义的两个点来完成的。而弧线会从当前CGContextRef的点开始，画到中心圆与第二条线的交点处。这样的画弧方式，在某些情况下可以使CGContextAddArcToPoint函数比CGPathAddArc用起来更加方便些
             */
            //CGAffineTransform transform = CGAffineTransformMakeRotation((22.5f * M_PI) / 180.0f);
            CGPathAddArc(path, NULL, centerX, centerY, radius, startAngle, endAngle, 0);
            CGPathAddLineToPoint(path,NULL, centerX, centerY);
            CGPathCloseSubpath(path);//关闭该path
            
            //Draw the shadowed slice (画弧形的阴影)
            
            CGContextSaveGState(context);
            CGContextAddPath(context, path);
            
           
            CGContextSetRGBFillColor(context, 0.5, 0.5, 0.5, 1);//填充颜色
            CGContextFillPath(context);
            CGContextRestoreGState(context);
            
            
            //Draw the left-right gradient(画左右边的渐变)
            
            //Draw the slice outline (画轮廓)
            CGContextSaveGState(context);
            CGContextAddPath(context, path);
            
            CGContextClip(context);
            CGContextAddPath(context, path);
            CGContextSetLineWidth(context, 0.5);
            UIColor *darken = [UIColor colorWithWhite:0.0 alpha:0.2];
            CGContextSetStrokeColorWithColor(context, darken.CGColor);
            CGContextStrokePath(context);
            CGContextRestoreGState(context);
            
            CGPathRelease(path);
            
          UIImageView *imageView = [[UIImageView alloc]initWithImage:  UIGraphicsGetImageFromCurrentImageContext()];
            [self addSubview:imageView];
            
        

        }
        
        
    }
    else{
        NSLog(@"不包含这个点");
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
