//
//  AlbumContentViewController.m
//  Gift
//
//  Created by Ruchi Varshney on 2/17/14.
//
//

#import "AlbumContentViewController.h"
#import "AlbumImageView.h"
#import "Picture.h"

@interface AlbumContentViewController ()

@property (nonatomic, strong) UIView *placementView;

@end

@implementation AlbumContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.album.template.themeLeft getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIGraphicsBeginImageContext(self.view.frame.size);
            [[UIImage imageWithData:data] drawInRect:self.view.bounds];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            self.view.backgroundColor = [UIColor colorWithPatternImage:image];
        }
    }];
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowRadius = 3.0f;
    self.view.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.view.layer.shadowOpacity = 0.5f;

    self.labelText.text = [NSString stringWithFormat:@"%d", self.pageNum];
    for (Picture *picture in self.pictures)
    {
        AlbumImageView *imageView = [[AlbumImageView alloc] initWithPicture:picture];
        [self.view addSubview:imageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)showPlacementViews
{
    NSDictionary *positionData = [self.album.template objectForKey:@"positionData"];
    NSNumber *templateWidth = [positionData objectForKey:@"w"];
    NSNumber *templateHeight = [positionData objectForKey:@"h"];
    NSArray *leftData = [positionData objectForKey:@"leftData"];
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    
    CGFloat widthRatio = viewWidth / [templateWidth floatValue];
    CGFloat heightRatio = viewHeight / [templateHeight floatValue];
    
    self.placementView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    for (NSDictionary *placement in leftData) {
        CGFloat x = [[placement objectForKey:@"x"] floatValue];
        CGFloat y = [[placement objectForKey:@"y"] floatValue];
        CGFloat w = [[placement objectForKey:@"w"] floatValue];
        CGFloat h = [[placement objectForKey:@"h"] floatValue];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x * widthRatio, y * heightRatio, w * widthRatio, h * heightRatio)];
        view.alpha = 1;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        view.layer.borderWidth = 2.0f;
        [self.placementView addSubview:view];
    }

    [self.view addSubview:self.placementView];
}

- (void)hidePlacementViews
{
    [self.placementView removeFromSuperview];
}

- (CGRect)placementRectForLocation:(CGPoint)location
{
    for (UIView *placementView in [self.placementView subviews]) {
        if (CGRectContainsPoint(placementView.frame, location)) {
            return placementView.frame;
        }
    }
    return CGRectZero;
}

@end
