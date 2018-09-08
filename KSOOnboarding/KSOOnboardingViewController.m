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
#import "KSOOnboardingItem+KSOOnboardingPrivateExtensions.h"
#import "KSOOnboardingTheme.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface KSOOnboardingViewController () <KSOOnboardingViewModelDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (strong,nonatomic) KSOOnboardingViewModel *viewModel;

@property (strong,nonatomic) UIView *backgroundView;
@property (strong,nonatomic) UIPageViewController *pageViewController;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (strong,nonatomic) UIButton *dismissButton;

@property (readonly,nonatomic) KSOOnboardingItem *currentOnboardingItem;

- (void)_updatePageControlForOnboardingItem:(KSOOnboardingItem *)onboardingItem;
- (void)_updateDismissButtonForOnboardingItem:(KSOOnboardingItem *)onboardingItem;
@end

@implementation KSOOnboardingViewController
#pragma mark *** Subclass Overrides ***
- (void)dealloc {
    KSTLogObject(self.class);
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    
    _viewModel = [[KSOOnboardingViewModel alloc] init];
    _viewModel.viewModelDelegate = self;
    
    return self;
}
#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    if ([self.delegate respondsToSelector:@selector(backgroundViewForOnboardingViewController:)]) {
        self.backgroundView = [self.delegate backgroundViewForOnboardingViewController:self];
        
        if (self.backgroundView != nil) {
            self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:self.backgroundView];
            
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.backgroundView}]];
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.backgroundView}]];
        }
    }
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [self addChildViewController:self.pageViewController];
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.pageViewController.view];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.pageViewController.view}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.pageViewController.view}]];
    
    [self.pageViewController didMoveToParentViewController:self];
    
    UIViewController<KSOOnboardingItemViewController> *viewController = [self.viewModel viewControllerForOnboardingItem:[self.viewModel onboardingItemAtIndex:0]];
    
    [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.dismissButton.titleLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleCallout;
    self.dismissButton.tintColor = self.theme.actionColor;
    [self.dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [self.dismissButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.viewModel dismiss];
    } forControlEvents:UIControlEventTouchUpInside];
    [self _updateDismissButtonForOnboardingItem:viewController.onboardingItem];
    [self.view addSubview:self.dismissButton];
    
    [NSLayoutConstraint activateConstraints:@[[self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToSystemSpacingBelowAnchor:self.dismissButton.bottomAnchor multiplier:1.0], [self.dismissButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]]];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.pageIndicatorTintColor = [self.theme.headlineColor colorWithAlphaComponent:0.33];
    self.pageControl.currentPageIndicatorTintColor = self.theme.headlineColor;
    self.pageControl.numberOfPages = self.viewModel.numberOfOnboardingItems;
    [self.view addSubview:self.pageControl];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-[bottom]" options:0 metrics:nil views:@{@"view": self.pageControl, @"bottom": self.dismissButton}]];
    [NSLayoutConstraint activateConstraints:@[[self.pageControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]]];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    KSOOnboardingItem *onboardingItem = [self.viewModel onboardingItemAtIndex:0];
    
    if (onboardingItem.viewDidAppearBlock != nil) {
        onboardingItem.viewDidAppearBlock(onboardingItem);
    }
}
#pragma mark KSOOnboardingViewModelDelegate
- (KSOOnboardingViewController *)onboardingViewControllerForOnboardingViewModel:(KSOOnboardingViewModel *)viewModel {
    return self;
}
#pragma mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewModel indexOfOnboardingItem:[(id<KSOOnboardingItemViewController>)viewController onboardingItem]];
    
    if ((++index) >= self.viewModel.numberOfOnboardingItems) {
        return nil;
    }
    
    return [self.viewModel viewControllerForOnboardingItem:[self.viewModel onboardingItemAtIndex:index]];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewModel indexOfOnboardingItem:[(id<KSOOnboardingItemViewController>)viewController onboardingItem]];
    
    if ((--index) < 0) {
        return nil;
    }
    
    return [self.viewModel viewControllerForOnboardingItem:[self.viewModel onboardingItemAtIndex:index]];
}
#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        KSOOnboardingItem *onboardingItem = self.currentOnboardingItem;
        
        [self _updatePageControlForOnboardingItem:onboardingItem];
        [self _updateDismissButtonForOnboardingItem:onboardingItem];
        
        if (onboardingItem.viewDidAppearBlock != nil) {
            onboardingItem.viewDidAppearBlock(onboardingItem);
        }
    }
}
#pragma mark *** Public Methods ***
- (void)gotoNextOnboardingItemAnimated:(BOOL)animated; {
    NSInteger index = [self.viewModel indexOfOnboardingItem:[(id<KSOOnboardingItemViewController>)self.pageViewController.viewControllers.firstObject onboardingItem]];
    
    if ((++index) >= self.viewModel.numberOfOnboardingItems) {
        return;
    }
    
    [self gotoOnboardingItem:[self.viewModel onboardingItemAtIndex:index] animated:animated];
}
- (void)gotoPreviousOnboardingItemAnimated:(BOOL)animated; {
    NSInteger index = [self.viewModel indexOfOnboardingItem:[(id<KSOOnboardingItemViewController>)self.pageViewController.viewControllers.firstObject onboardingItem]];
    
    if ((--index) < 0) {
        return;
    }
    
    [self gotoOnboardingItem:[self.viewModel onboardingItemAtIndex:index] animated:animated];
}
- (void)gotoOnboardingItem:(KSOOnboardingItem *)onboardingItem animated:(BOOL)animated; {
    NSInteger currentIndex = [self.viewModel indexOfOnboardingItem:[(id<KSOOnboardingItemViewController>)self.pageViewController.viewControllers.firstObject onboardingItem]];
    NSInteger index = [self.viewModel indexOfOnboardingItem:onboardingItem];
    
    if (index == currentIndex) {
        return;
    }
    
    UIViewController<KSOOnboardingItemViewController> *viewController = [self.viewModel viewControllerForOnboardingItem:onboardingItem];
    UIPageViewControllerNavigationDirection direction = index < currentIndex ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
    
    [self.pageViewController setViewControllers:@[viewController] direction:direction animated:animated completion:^(BOOL finished) {
        [self _updatePageControlForOnboardingItem:onboardingItem];
        [self _updateDismissButtonForOnboardingItem:onboardingItem];
        
        if (onboardingItem.viewDidAppearBlock != nil) {
            onboardingItem.viewDidAppearBlock(onboardingItem);
        }
    }];
}
#pragma mark Properties
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
#pragma mark -
@dynamic theme;
- (KSOOnboardingTheme *)theme {
    return self.viewModel.theme;
}
- (void)setTheme:(KSOOnboardingTheme *)theme {
    self.viewModel.theme = theme;
}
#pragma mark *** Private Methods ***
- (void)_updatePageControlForOnboardingItem:(KSOOnboardingItem *)onboardingItem; {
    self.pageControl.currentPage = [self.viewModel indexOfOnboardingItem:onboardingItem];
}
- (void)_updateDismissButtonForOnboardingItem:(KSOOnboardingItem *)onboardingItem; {
    self.dismissButton.enabled = [self.viewModel canDismissForOnboardingItem:onboardingItem];
}
#pragma mark Properties
- (KSOOnboardingItem *)currentOnboardingItem {
    return [(id<KSOOnboardingItemViewController>)self.pageViewController.viewControllers.firstObject onboardingItem];
}

@end
