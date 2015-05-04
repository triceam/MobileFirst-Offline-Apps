//
//  ViewController.h
//  GeoPix
//
//  Created by Andrew Trice on 3/12/15.
//  Copyright (c) 2015 Andrew Trice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <IMFCore/IMFCore.h>
#import <CloudantToolkit/CloudantToolkit.h>
#import "DataManager.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    IBOutlet UILabel *locationLabel;
    IBOutlet UILabel *statusLabel;
    IBOutlet UIImageView *currentImage;
    
    IBOutlet UIButton *cameraButton;
    IBOutlet UIButton *photoButton;
    IMFLogger *logger;
}



@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLLocation* currentLocation;


- (IBAction) cameraButtonTapped:(UIButton *)sender;
- (IBAction) photoLibButtonTapped:(UIButton *)sender;
- (void) presentImagePicker:(UIImagePickerControllerSourceType) sourceType;

@end

