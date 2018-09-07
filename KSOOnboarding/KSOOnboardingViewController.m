//
//  KSOOnboardingViewController.m
//  KSOOnboarding-iOS
//
//  Created by William Towe on 9/6/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KSOOnboardingViewController.h"
#import "KSOOnboardingViewModel.h"

#import <Ditko/Ditko.h>

@interface KSOOnboardingViewController () <UIPageViewControllerDataSource>
@property (strong,nonatomic) KSOOnboardingViewModel *viewModel;

@property (strong,nonatomic) UIView *backgroundView;
@property (strong,nonatomic) UIPageViewController *pageViewController;
@end

@implementation KSOOnboardingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    
    _viewModel = [[KSOOnboardingViewModel alloc] initWithOnboardingItems:nil onboardingViewController:self];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KDIGradientView *backgroundView = [[KDIGradientView alloc] initWithFrame:CGRectZero];
    
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    backgroundView.colors = @[KDIColorRandomHSB(),
                              KDIColorRandomHSB(),
                              KDIColorRandomHSB()];
    
    self.backgroundView = backgroundView;
    [self.view addSubview:self.backgroundView];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.backgroundView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.backgroundView}]];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    
    UIViewController<KSOOnboardingItemViewController> *viewController = [self.viewModel viewControllerForOnboardingItem:[self.viewModel onboardingItemAtIndex:0]];
    
    [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.pageViewController.view];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.pageViewController.view}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.pageViewController.view}]];
    
    [self.pageViewController didMoveToParentViewController:self];
}

- (instancetype)initWithOnboardingItems:(NSArray<KSOOnboardingItem *> *)onboardingItems {
    if (!(self = [super initWithNibName:nil bundle:nil]))
        return nil;
    
    _viewModel = [[KSOOnboardingViewModel alloc] initWithOnboardingItems:onboardingItems onboardingViewController:self];
    
    return self;
}

@dynamic dataSource;
- (id<KSOOnboardingViewControllerDataSource>)dataSource {
    return self.viewModel.dataSource;
}
- (void)setDataSource:(id<KSOOnboardingViewControllerDataSource>)dataSource {
    self.viewModel.dataSource = dataSource;
}
@dynamic delegate;
- (id<KSOOnboardingViewControllerDelegate>)delegate {
    return self.viewModel.delegate;
}
- (void)setDelegate:(id<KSOOnboardingViewControllerDelegate>)delegate {
    self.viewModel.delegate = delegate;
}

@end
