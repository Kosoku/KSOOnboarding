//
//  ViewController.m
//  Demo-iOS
//
//  Created by William Towe on 9/6/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "ViewController.h"
#import "LoremIpsum.h"

#import <KSOOnboarding/KSOOnboarding.h>
#import <Ditko/Ditko.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>
#import <Stanley/Stanley.h>
#import <KSOColorPicker/KSOColorPicker.h>

typedef NS_ENUM(NSInteger, BackgroundViewType) {
    BackgroundViewTypeNone = 0,
    BackgroundViewTypeImage,
    BackgroundViewTypeMovie
};

typedef NS_ENUM(NSInteger, BlurEffectStyle) {
    BlurEffectStyleNone = NSIntegerMin,
    BlurEffectStyleExtraLight = UIBlurEffectStyleExtraLight,
    BlurEffectStyleLight = UIBlurEffectStyleLight,
    BlurEffectStyleDark = UIBlurEffectStyleDark,
#if (TARGET_OS_TV)
    BlurEffectStyleExtraDark = UIBlurEffectStyleExtraDark,
#endif
    BlurEffectStyleRegular = UIBlurEffectStyleRegular,
    BlurEffectStyleProminent = UIBlurEffectStyleProminent
};

static CGSize const kImageSize = {.width=128, .height=128};

@interface BackgroundViewTypeRow : NSObject <KDIPickerViewButtonRow>
@property (assign,nonatomic) BackgroundViewType type;
+ (instancetype)backgroundViewType:(BackgroundViewType)type;
@end

@interface BlurEffectStyleRow : NSObject <KDIPickerViewButtonRow>
@property (assign,nonatomic) BlurEffectStyle style;
+ (instancetype)blurEffectStyle:(BlurEffectStyle)style;
@end

@interface ViewController () <KSOOnboardingViewControllerDataSource, KSOOnboardingViewControllerDelegate>
@property (weak,nonatomic) IBOutlet KDIPickerViewButton *backgroundViewPickerViewButton;
@property (weak,nonatomic) IBOutlet KDIPickerViewButton *blurEffectPickerViewButton;
@property (weak,nonatomic) IBOutlet UIButton *overlayColorButton;

@property (assign,nonatomic) BackgroundViewType selectedBackgroundViewType;
@property (strong,nonatomic) UIColor *selectedOverlayColor;
@property (assign,nonatomic) BlurEffectStyle selectedBlurEffectStyle;

@property (copy,nonatomic) NSArray<KSOOnboardingItem *> *onboardingItems;
@property (weak,nonatomic) KSOOnboardingViewController *onboardingViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    self.title = @"KSOOnboarding";
    
    self.selectedBackgroundViewType = BackgroundViewTypeNone;
    self.selectedBlurEffectStyle = BlurEffectStyleNone;
    
    [self.backgroundViewPickerViewButton KDI_setPickerViewButtonRows:@[[BackgroundViewTypeRow backgroundViewType:BackgroundViewTypeNone], [BackgroundViewTypeRow backgroundViewType:BackgroundViewTypeImage], [BackgroundViewTypeRow backgroundViewType:BackgroundViewTypeMovie]] titleForSelectedRowBlock:^NSString *(id<KDIPickerViewButtonRow>  _Nonnull row) {
        return [NSString stringWithFormat:@"Background View Type: %@",row.pickerViewButtonRowTitle];
    } didSelectRowBlock:^(BackgroundViewTypeRow * _Nonnull row) {
        self.selectedBackgroundViewType = row.type;
    }];
    
    [self.blurEffectPickerViewButton KDI_setPickerViewButtonRows:@[[BlurEffectStyleRow blurEffectStyle:BlurEffectStyleNone], [BlurEffectStyleRow blurEffectStyle:BlurEffectStyleLight], [BlurEffectStyleRow blurEffectStyle:BlurEffectStyleExtraLight], [BlurEffectStyleRow blurEffectStyle:BlurEffectStyleDark], [BlurEffectStyleRow blurEffectStyle:BlurEffectStyleRegular], [BlurEffectStyleRow blurEffectStyle:BlurEffectStyleProminent]] titleForSelectedRowBlock:^NSString *(id<KDIPickerViewButtonRow>  _Nonnull row) {
        return [NSString stringWithFormat:@"Blur Effect Style: %@",row.pickerViewButtonRowTitle];
    } didSelectRowBlock:^(BlurEffectStyleRow * _Nonnull row) {
        self.selectedBlurEffectStyle = row.style;
    }];
    
    [self.overlayColorButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self KSO_presentColorPickerViewController:[[KSOColorPickerViewController alloc] initWithColorPickerView:nil] animated:YES completion:^(UIColor * _Nullable color) {
            self.selectedOverlayColor = color;
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem KDI_barButtonItemWithTitle:@"Onboard" style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        [self _buttonAction:nil];
    }]];
}

- (NSInteger)numberOfOnboardingItemsForOnboardingViewController:(__kindof KSOOnboardingViewController *)viewController {
    return self.onboardingItems.count;
}
- (KSOOnboardingItem *)onboardingViewController:(__kindof KSOOnboardingViewController *)viewController onboardingItemAtIndex:(NSInteger)index {
    return self.onboardingItems[index];
}

- (UIView *)backgroundViewForOnboardingViewController:(__kindof KSOOnboardingViewController *)viewController {
    id retval = nil;
    
    switch (self.selectedBackgroundViewType) {
        case BackgroundViewTypeNone:
            break;
        case BackgroundViewTypeMovie: {
            KSOOnboardingMovieBackgroundView *backgroundView = [[KSOOnboardingMovieBackgroundView alloc] initWithAsset:[AVAsset assetWithURL:[NSBundle.mainBundle URLForResource:@"movie" withExtension:@"mp4"]]];
            
            backgroundView.muted = YES;
            
            retval = backgroundView;
        }
            break;
        case BackgroundViewTypeImage: {
            KSOOnboardingImageBackgroundView *backgroundView = [[KSOOnboardingImageBackgroundView alloc] initWithImage:[UIImage imageNamed:@"background"]];
            
            retval = backgroundView;
        }
            break;
    }
    
    if ([retval respondsToSelector:@selector(setBlurEffect:)]) {
        switch (self.selectedBlurEffectStyle) {
            case BlurEffectStyleNone:
                break;
            default:
                [retval setBlurEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyle)self.selectedBlurEffectStyle]];
                break;
        }
    }
    if ([retval respondsToSelector:@selector(setOverlayColor:)]) {
        [retval setOverlayColor:self.selectedOverlayColor];
    }
    
    return retval;
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
    viewController.dismissButtonTitle = @"Skip";
    
    self.onboardingViewController = viewController;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)setSelectedOverlayColor:(UIColor *)selectedOverlayColor {
    _selectedOverlayColor = selectedOverlayColor;
    
    if (_selectedOverlayColor == nil) {
        [self.overlayColorButton setImage:nil forState:UIControlStateNormal];
        [self.overlayColorButton setTitle:@"Overlay Color: None" forState:UIControlStateNormal];
    }
    else {
        CGSize size = CGSizeMake(24, 24);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        [_selectedOverlayColor setFill];
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext().KDI_originalImage;
        
        UIGraphicsEndImageContext();
        
        [self.overlayColorButton setImage:image forState:UIControlStateNormal];
        [self.overlayColorButton setTitle:@"Overlay Color" forState:UIControlStateNormal];
    }
}

@end

@implementation BackgroundViewTypeRow
+ (instancetype)backgroundViewType:(BackgroundViewType)type {
    BackgroundViewTypeRow *retval = [[BackgroundViewTypeRow alloc] init];
    
    retval.type = type;
    
    return retval;
}
- (NSString *)pickerViewButtonRowTitle {
    switch (self.type) {
        case BackgroundViewTypeNone:
            return @"None";
        case BackgroundViewTypeImage:
            return @"Image";
        case BackgroundViewTypeMovie:
            return @"Movie";
    }
}
@end

@implementation BlurEffectStyleRow
+ (instancetype)blurEffectStyle:(BlurEffectStyle)style; {
    BlurEffectStyleRow *retval = [[BlurEffectStyleRow alloc] init];
    
    retval.style = style;
    
    return retval;
}
- (NSString *)pickerViewButtonRowTitle {
    switch (self.style) {
        case BlurEffectStyleDark:
            return @"Dark";
        case BlurEffectStyleNone:
            return @"None";
        case BlurEffectStyleLight:
            return @"Light";
        case BlurEffectStyleRegular:
            return @"Regular";
        case BlurEffectStyleProminent:
            return @"Prominent";
        case BlurEffectStyleExtraLight:
            return @"Extra Light";
#if (TARGET_OS_TV)
        case BlurEffectStyleExtraDark:
            return @"Extra Dark";
#endif
    }
}
@end
