//
//  KSOOnboardingItemDefaultViewController.m
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

#import "KSOOnboardingDefaultItemViewController.h"
#import "KSOOnboardingTheme.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface KSOOnboardingDefaultItemViewController ()
@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *headlineLabel;
@property (strong,nonatomic) UILabel *bodyLabel;
@property (strong,nonatomic) UIButton *actionButton;
@end

@implementation KSOOnboardingDefaultItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    self.view.backgroundColor = UIColor.clearColor;
    
    self.stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    self.stackView.spacing = 20.0;
    [self.view addSubview:self.stackView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.tintColor = self.onboardingTheme.imageColor;
    self.imageView.image = self.onboardingItem.image;
    [self.stackView addArrangedSubview:self.imageView];
    
    self.headlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.headlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headlineLabel.numberOfLines = 0;
    self.headlineLabel.textAlignment = NSTextAlignmentCenter;
    self.headlineLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleHeadline;
    self.headlineLabel.textColor = self.onboardingTheme.headlineColor;
    self.headlineLabel.text = self.onboardingItem.headline;
    [self.stackView addArrangedSubview:self.headlineLabel];
    
    self.bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.textAlignment = NSTextAlignmentCenter;
    self.bodyLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleBody;
    self.bodyLabel.textColor = self.onboardingTheme.bodyColor;
    self.bodyLabel.text = self.onboardingItem.body;
    [self.stackView addArrangedSubview:self.bodyLabel];
    
    self.actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.actionButton.tintColor = self.onboardingTheme.actionColor;
    self.actionButton.titleLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleCallout;
    [self.actionButton setTitle:self.onboardingItem.action forState:UIControlStateNormal];
    [self.actionButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        if (self.onboardingItem.actionBlock != nil) {
            self.onboardingItem.actionBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addArrangedSubview:self.actionButton];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": self.stackView}]];
    [NSLayoutConstraint activateConstraints:@[[self.stackView.topAnchor constraintEqualToSystemSpacingBelowAnchor:self.view.safeAreaLayoutGuide.topAnchor multiplier:2.0], [self.view.safeAreaLayoutGuide.bottomAnchor constraintGreaterThanOrEqualToSystemSpacingBelowAnchor:self.stackView.bottomAnchor multiplier:1.0]]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.headlineLabel}]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.bodyLabel}]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.onboardingItem.viewWillAppearBlock != nil) {
        self.onboardingItem.viewWillAppearBlock();
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.onboardingItem.viewDidAppearBlock != nil) {
        self.onboardingItem.viewDidAppearBlock();
    }
}

@synthesize onboardingItem=_onboardingItem;
@synthesize onboardingTheme=_onboardingTheme;

@end
