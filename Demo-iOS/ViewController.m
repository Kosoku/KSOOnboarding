//
//  ViewController.m
//  Demo-iOS
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

#import "ViewController.h"
#import "LoremIpsum.h"

#import <KSOOnboarding/KSOOnboarding.h>
#import <Ditko/Ditko.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>
#import <Stanley/Stanley.h>

static CGSize const kImageSize = {.width=128, .height=128};

@interface ViewController () <KSOOnboardingViewControllerDataSource, KSOOnboardingViewControllerDelegate>
@property (copy,nonatomic) NSArray<KSOOnboardingItem *> *onboardingItems;
@property (weak,nonatomic) KSOOnboardingViewController *onboardingViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfOnboardingItemsForOnboardingViewController:(__kindof KSOOnboardingViewController *)viewController {
    return self.onboardingItems.count;
}
- (KSOOnboardingItem *)onboardingViewController:(__kindof KSOOnboardingViewController *)viewController onboardingItemAtIndex:(NSInteger)index {
    return self.onboardingItems[index];
}

- (UIView *)backgroundViewForOnboardingViewController:(__kindof KSOOnboardingViewController *)viewController {
    KSOOnboardingMovieBackgroundView *backgroundView = [[KSOOnboardingMovieBackgroundView alloc] initWithAsset:[AVAsset assetWithURL:[NSBundle.mainBundle URLForResource:@"movie" withExtension:@"mp4"]]];
    
    backgroundView.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    backgroundView.muted = YES;
    
    return backgroundView;
}

- (IBAction)_buttonAction:(id)sender {
    NSMutableArray<KSOOnboardingItem *> *temp = [[NSMutableArray alloc] init];
    NSArray *imageStrings = @[@"\uf641",
                              @"\uf2b9",
                              @"\uf5d0",
                              @"\uf13d",
                              @"\uf5d1"];
    
    for (NSInteger i=0; i<5; i++) {
        [temp addObject:[KSOOnboardingItem onboardingItemWithDictionary:@{KSOOnboardingItemKeyImage: [UIImage KSO_fontAwesomeSolidImageWithString:imageStrings[i] size:kImageSize].KDI_templateImage, KSOOnboardingItemKeyHeadline: LoremIpsum.title, KSOOnboardingItemKeyBody: [LoremIpsum sentencesWithNumber:2], KSOOnboardingItemKeyAction: LoremIpsum.word.localizedCapitalizedString, KSOOnboardingItemKeyActionBlock: ^(KSOOnboardingItem *item){
            if (i == 4) {
                [self.onboardingViewController dismissOnboardingViewControllerAnimated:YES completion:nil];
            }
            else {
                [UIAlertController KDI_presentAlertControllerWithOptions:@{KDIUIAlertControllerOptionsKeyTitle: LoremIpsum.word.localizedCapitalizedString, KDIUIAlertControllerOptionsKeyMessage: item.headline} completion:^(__kindof UIAlertController * _Nonnull alertController, NSInteger buttonIndex) {
                    [self.onboardingViewController gotoNextOnboardingItemAnimated:YES];
                }];
            }
        }, KSOOnboardingItemKeyViewDidAppearBlock: ^(KSOOnboardingItem *item){
            if (i % 2 == 0) {
                [UIAlertController KDI_presentAlertControllerWithOptions:@{KDIUIAlertControllerOptionsKeyTitle: LoremIpsum.word.localizedCapitalizedString, KDIUIAlertControllerOptionsKeyMessage: item.headline} completion:nil];
            }
        }}]];
    }
    
    self.onboardingItems = temp;
    
    KSOOnboardingViewController *viewController = [[KSOOnboardingViewController alloc] initWithNibName:nil bundle:nil];
    
    viewController.dataSource = self;
    viewController.delegate = self;
    
    self.onboardingViewController = viewController;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
