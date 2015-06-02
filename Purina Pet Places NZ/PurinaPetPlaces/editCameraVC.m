//
//  editCameraVC.m
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/9.
//
//

#import "editCameraVC.h"
#import <Social/Social.h>
@interface editCameraVC ()<UIDocumentInteractionControllerDelegate>
@property(nonatomic,strong)NSMutableArray *imageArrForDog;

@property (nonatomic, strong) UIDocumentInteractionController *documentController;
@property(nonatomic,strong)UIButton *dogBtn;
@property(nonatomic,strong)UIButton *frameBtn;
@property(nonatomic,strong)UIButton *saveBtn;

@property(nonatomic,strong)UIImageView *currentImage;

@end

@implementation editCameraVC
{
    NSString *resultStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showCustomeNav];
    [self.view setBackgroundColor:[UIColor colorWithRed:244/255.f green:241/255.f blue:230/255.f alpha:0.8]];
    [self createBgView];
//    [self createEditLabel];
    [self createImageView];
//    [self createCurrent];
    [self createScroller];
    [self createDogFrame];
    
    [self createBottom];
}


-(void)createBottom
{
    self.bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 2+CGRectGetMaxY(self.dogFrameview.frame), SCREEN_WIDTH, self.bgView.frame.size.height - CGRectGetMaxY(self.dogFrameview.frame))];
    self.bottom.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.bottom];
    
    CGFloat bottomHeight = CGRectGetHeight(self.bottom.frame);
    CGFloat perHeightBottom = bottomHeight/3.f;
    
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveBtn setFrame:CGRectMake((SCREEN_WIDTH-perHeightBottom)/2,5,perHeightBottom, perHeightBottom )];
    //    [self.saveBtn setImage:[UIImage imageNamed:@"bang.png"] forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"SAVE" forState:UIControlStateNormal];
    self.saveBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveBtn setBackgroundColor:[UIColor redColor]];
    [self.saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom addSubview:self.saveBtn];

    
    UILabel *share = [[UILabel alloc]initWithFrame:CGRectMake(0, perHeightBottom+5, SCREEN_WIDTH, perHeightBottom)];
    share.text = @"Share";
    [share setFont:[UIFont fontWithName:@"Antenna" size:20]];
    share.textAlignment = NSTextAlignmentCenter;
    [self.bottom addSubview:share];
    
    self.facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.facebookBtn setFrame:CGRectMake((SCREEN_WIDTH - perHeightBottom*3-40)/2+10, CGRectGetMaxY(share.frame)-5, perHeightBottom-5, perHeightBottom-5)];
    [self.facebookBtn setImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
    [self.facebookBtn addTarget:self action:@selector(faceBookShare:) forControlEvents:UIControlEventTouchUpInside];
//    [self.facebookBtn setBackgroundColor:[UIColor redColor]];
    [self.bottom addSubview:self.facebookBtn];
    
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cameraBtn setFrame:CGRectMake(CGRectGetMaxX(self.facebookBtn.frame)+20, CGRectGetMaxY(share.frame)-5, perHeightBottom-5, perHeightBottom-5)];
    
    [self.cameraBtn setImage:[UIImage imageNamed:@"insta.png"] forState:UIControlStateNormal];
//    [self.cameraBtn setBackgroundColor:[UIColor redColor]];
    
    [self.cameraBtn addTarget:self action:@selector(instaGramWallPost) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom addSubview:self.cameraBtn];
    
    self.twitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.twitterBtn setFrame:CGRectMake(CGRectGetMaxX(self.cameraBtn.frame)+20, CGRectGetMaxY(share.frame)-5, perHeightBottom-5, perHeightBottom-5)];
    [self.twitterBtn setImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
    [self.twitterBtn addTarget:self action:@selector(twitterShare:) forControlEvents:UIControlEventTouchUpInside];
//    [self.twitterBtn setBackgroundColor:[UIColor redColor]];
    [self.bottom addSubview:self.twitterBtn];
    
    
    
}




-(void)instaGramWallPost
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if([[UIApplication sharedApplication] canOpenURL:instagramURL]) //check for App is install or not
    {
        NSData *imageData = UIImagePNGRepresentation(self.dogImageView.image); //convert image into .png format.
        NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
        NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
        NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"insta.igo"]]; //add our image to the path
        [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; //finally save the path (image)
        NSLog(@"image saved");
        
        CGRect rect = CGRectMake(0 ,0 , 0, 0);
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIGraphicsEndImageContext();
        NSString *fileNameToSave = [NSString stringWithFormat:@"Documents/insta.igo"];
        NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:fileNameToSave];
        NSLog(@"jpg path %@",jpgPath);
        NSString *newJpgPath = [NSString stringWithFormat:@"file://%@",jpgPath];
        NSLog(@"with File path %@",newJpgPath);
        NSURL *igImageHookFile = [[NSURL alloc]initFileURLWithPath:newJpgPath];
        NSLog(@"url Path %@",igImageHookFile);
        
        self.documentController.UTI = @"com.instagram.exclusivegram";
        self.documentController = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
        self.documentController=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
        NSString *caption = @"#Your Text"; //settext as Default Caption
        self.documentController.annotation=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",caption],@"InstagramCaption", nil];
        [self.documentController presentOpenInMenuFromRect:rect inView: self.view animated:YES];
    }
    else
    {
        NSLog (@"Instagram not found");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Instagram not found" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    NSLog(@"file url %@",fileURL);
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    
    return interactionController;
}


-(void)instagramShare:(UIButton *)sender
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
//        CGFloat cropVal = (imageMain.image.size.height > imageMain.image.size.width ? imageMain.image.size.width : imageMain.image.size.height);
//        
//        cropVal *= [imageMain.image scale];
//        
//        CGRect cropRect = (CGRect){.size.height = cropVal, .size.width = cropVal};
//        CGImageRef imageRef = CGImageCreateWithImageInRect([imageMain.image CGImage], cropRect);
//        
//        NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:imageRef], 1.0);
//        CGImageRelease(imageRef);
//        
//        NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
//        if (![imageData writeToFile:writePath atomically:YES]) {
//            // failure
//            NSLog(@"image save failed to path %@", writePath);
//            return;
//        } else {
//            // success.
//        }
        
        // send it to instagram.
        NSURL *fileURL = [NSURL fileURLWithPath:resultStr];
        self.documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        self.documentController.delegate = self;
        [self.documentController setUTI:@"com.instagram.exclusivegram"];
        [self.documentController setAnnotation:@{@"InstagramCaption" : @"We are making fun"}];
        [self.documentController presentOpenInMenuFromRect:CGRectMake(0, 0, 320, 480) inView:self.view animated:YES];
    }
    else
    {
        NSLog (@"Instagram not found");
        
    }
}


-(void)faceBookShare:(UIButton *)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebook setInitialText:@"share pet Space"];
        [self presentViewController:facebook animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"FaceBook not found" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
    
}

-(void)twitterShare:(UIButton *)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *twitterSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitterSheet setInitialText:@"share pet Space"];
        [self presentViewController:twitterSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Twitter not found" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];

    }

}

-(void)createDogFrame
{
    self.dogFrameview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scroller.frame), SCREEN_WIDTH, 50)];
    [self.dogFrameview  setBackgroundColor:[UIColor colorWithRed:244/255.f green:241/255.f blue:230/255.f alpha:1]];
    [self.bgView addSubview:self.dogFrameview];
    
    self.dogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dogBtn setFrame:CGRectMake((SCREEN_WIDTH-80)/2, 10, 30, 30)];
    [self.dogBtn setImage:[UIImage imageNamed:@"dogtu.png"] forState:UIControlStateNormal];
    [self.dogBtn addTarget:self action:@selector(dogBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.dogFrameview addSubview:self.dogBtn];
    
    self.frameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.frameBtn setFrame:CGRectMake(CGRectGetMaxX(self.dogBtn.frame)+20, 10, 30, 30)];
    [self.frameBtn setImage:[UIImage imageNamed:@"kuagn.png"] forState:UIControlStateNormal];
    [self.frameBtn addTarget:self action:@selector(frameBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.dogFrameview addSubview:self.frameBtn];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scroller.frame), SCREEN_WIDTH, 1)];
    [line setBackgroundColor:[UIColor blackColor]];
    [self.bgView addSubview:line];
    

}

-(void)screenShots
{
    CGSize imageSize = self.dogImageView.frame.size;
    
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    }
    else
    {
        UIGraphicsBeginImageContext(imageSize);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow * window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            [[self.dogImageView layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    UIGraphicsEndImageContext();
    DBHelper *single = [DBHelper sharedInstance];
    if(single.iimm != nil)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        single.iimm.dateTimes = [formatter stringFromDate:[NSDate date]];
        
        
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dogOrcatImage/"];
        single.iimm.path = [imagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",single.iimm.dateTimes]];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [imageData writeToFile:single.iimm.path atomically:YES];
        [single updateImageItem:single.iimm];

        
    }


    
    
}



-(void)saveBtn:(UIButton *)sender
{
    [self screenShots];
}
-(void)frameBtn:(UIButton *)sender
{
    for(UIView *tmp in self.scroller.subviews)
    {
        [tmp removeFromSuperview];
    }
    [self createContentStart:31 andEnd:40];
    
}
-(void)dogBtn:(UIButton *)sender
{
    for(UIView *tmp in self.scroller.subviews)
    {
        [tmp removeFromSuperview];
    }
    [self createContentStart:11 andEnd:22];
}

-(void)createCurrent
{
    self.currentImage = [[UIImageView alloc]init];
    [self.currentImage setBackgroundColor:[UIColor clearColor]];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(currentPan:)];
    [self.currentImage addGestureRecognizer:pan];
    
    [self.bgView addSubview:self.currentImage];
}




-(void)createScroller
{
    UIView *big = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dogImageView.frame) , SCREEN_WIDTH, 50)];
    [big setBackgroundColor:[UIColor lightGrayColor]];
//    big.layer.backgroundColor = [UIColor blackColor].CGColor;
//    big.alpha = 0.4;

    [self.bgView addSubview:big];
    
    self.scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(self.dogImageView.frame), SCREEN_WIDTH-50, 50)];
    self.scroller.backgroundColor = [UIColor clearColor];
    self.scroller.alpha = 1;
    self.scroller.bounces = YES;
    
    [self.scroller setScrollEnabled:YES];
    self.scroller.contentSize = CGSizeMake(50*12+ 12*10 , 50);
    [self.bgView addSubview:self.scroller];
    [self createContentStart:11 andEnd:22];
}

-(void)createContentStart:(int)a andEnd:(int)b
{
    self.imageArrForDog = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i=a;i<=b;i++)
    {
        NSString *image = [NSString stringWithFormat:@"%d.png",i];
        [self.imageArrForDog addObject:image];
    }
    for(int i=0;i<self.imageArrForDog.count;i++)
    {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*50+10+(i*10), 0, 50, 50)];
        imageview.userInteractionEnabled = YES;
 

        UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(tipClict:)];
        [imageview addGestureRecognizer:tap];
        
        
        imageview.image = [UIImage imageNamed:self.imageArrForDog[i]];
        [self.scroller addSubview:imageview];
    }

}

-(void)tipClict:(UIPanGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        UIImageView *tmpImg = (UIImageView*)gesture.view;
        UIImageView *currenttmp = [[UIImageView alloc]initWithFrame:tmpImg.frame];
        currenttmp.userInteractionEnabled = YES;
//        currenttmp.backgroundColor = [UIColor redColor];
        currenttmp.image = tmpImg.image;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pantwo:)];
        [currenttmp addGestureRecognizer:pan];
        [self.dogImageView addSubview:currenttmp];
        self.currentImage = currenttmp;
    
        
    }
    CGPoint point = [gesture locationInView:self.dogImageView];
    
    self.currentImage.center = CGPointMake( point.x-25,point.y-25);

//    if(gesture.state == UIGestureRecognizerStateEnded)
//    {
    
//    }
    
    [gesture setTranslation:CGPointMake(0, 0) inView:self.dogImageView];
    
    
}

-(void)pantwo:(UIPanGestureRecognizer *)pan
{
    UIImageView *view = (UIImageView *)pan.view;
    self.currentImage = view;
    CGPoint point = [pan translationInView:self.view];
    self.currentImage.center = CGPointMake(point.x+view.center.x, point.y+view.center.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self.dogImageView];
}

-(void)createImageView
{
    self.dogImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 200)];
    self.dogImageView.layer.masksToBounds = YES;
    self.dogImageView.userInteractionEnabled = YES;

    NSURL *docsUrl = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
    resultStr = [[docsUrl path]stringByAppendingPathComponent:[NSString stringWithFormat:@"dogOrcatImage/%@",[self.model.path lastPathComponent]]];
    self.dogImageView.image = [UIImage imageWithContentsOfFile:resultStr];
    [self.bgView addSubview:self.dogImageView];
    
}


-(void)createEditLabel
{
    self.editLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40)];
    [self.editLabel setText:@"Edit"];
    [self.editLabel setFont:[UIFont fontWithName:@"Antenna" size:20]];
    [self.editLabel setTextColor:[UIColor blackColor]];
    self.editLabel.backgroundColor = [UIColor clearColor];
    self.editLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.editLabel];
}






-(void)createBgView
{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
//    [self.bgView setBackgroundColor:[UIColor colorWithRed:244/255.f green:241/255.f blue:230/255.f alpha:1]];
    [self.view addSubview:self.bgView];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
