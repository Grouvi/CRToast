//
//  CRToastViewController.m
//  CRToastDemo
//
//  Created by Daniel on 12/19/14.
//  Copyright (c) 2014 Collin Ruffenach. All rights reserved.
//

#import "CRToastViewController.h"
#import "CRToast.h"
#import "CRToastLayoutHelpers.h"

#pragma mark - CRToastContainerView
@interface CRToastContainerView : UIView
@end

@implementation CRToastContainerView
@end

#pragma mark - CRToastViewController
@interface CRToastViewController ()
@end

@implementation CRToastViewController

UIStatusBarStyle statusBarStyle;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _autorotate = NO;
    }
    return self;
}


-(BOOL)prefersStatusBarHidden {
    UIInterfaceOrientation orientation = CRGetDeviceOrientation();
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return YES;
    }
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return statusBarStyle;
}

- (void)statusBarStyle:(UIStatusBarStyle)newStatusBarStyle {
    statusBarStyle = newStatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)shouldAutorotate {
    return _autorotate;
}

- (void)loadView {
    self.view = [[CRToastContainerView alloc] init];
}

/*- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (self.toastView) {
        CGSize notificationSize = CRNotificationViewSizeForOrientation(self.notification.notificationType, self.notification.preferredHeight, toInterfaceOrientation);
        self.toastView.frame = CGRectMake(0, 0, notificationSize.width, notificationSize.height);
    }
}*/


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    //Not the best solution to set the height manually. But it fits our needs. Nobody cares
    int notificationHeight;
    if (size.width > size.height) { // Orientation is landscape
        notificationHeight = 33;
    } else {
        notificationHeight = 64;
    }
    
    
    if (self.toastView) {
        CGSize notificationSize = CGSizeMake(size.width, notificationHeight);
        self.toastView.frame = CGRectMake(0, 0, notificationSize.width, notificationSize.height);
    }
    
}

@end
