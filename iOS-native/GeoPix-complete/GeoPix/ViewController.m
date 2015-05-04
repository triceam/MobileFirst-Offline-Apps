//
//  ViewController.m
//  GeoPix
//
//  Created by Andrew Trice on 3/12/15.
//  Copyright (c) 2015 Andrew Trice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    logger = [IMFLogger loggerForName:NSStringFromClass([self class])];
    [logger logDebugWithMessages:@"initializing locationManager"];
    
    if (self.locationManager == nil)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 1; // meters
    
    BOOL enabled = [CLLocationManager locationServicesEnabled];
    if ( enabled ) {
        [logger logDebugWithMessages:@"location services startUpdatingLocation"];
        [self.locationManager startUpdatingLocation];
    }
    else {
        [logger logErrorWithMessages:@"location services disabled"];
    }
    
    
    IMFAuthorizationManager *authManager = [IMFAuthorizationManager sharedInstance];
    [authManager obtainAuthorizationHeaderWithCompletionHandler:^(IMFResponse *response, NSError *error) {
        //intialize singleton data manager
        
        [DataManager sharedInstance];
        
        //should transition to "active/logged in" view]
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"ReplicationStart"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"ReplicationStatus"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"ReplicationError"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"ReplicationComplete"
                                               object:nil];
}

-(void) receiveNotification:(NSNotification *) notification {
    
    NSString *message;
    if ([[notification name] isEqualToString:@"ReplicationStart"]) {
        
        message = @"Replication Started";
    }
    else if ([[notification name] isEqualToString:@"ReplicationComplete"]) {
        
        message = @"Replication Complete";
    }
    else if ([[notification name] isEqualToString:@"ReplicationStatus"]) {
        
        NSDictionary *userInfo = notification.userInfo;
        message = [NSString stringWithFormat:@"Replication %@", [userInfo valueForKey:@"status"] ];
    }
    else {
        
        message = @"Replication Error";
    }
    statusLabel.text = message;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power.
    self.currentLocation = [locations lastObject];
    NSDate* eventDate = self.currentLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        /*NSLog(@"latitude %+.6f, longitude %+.6f\n",
              self.currentLocation.coordinate.latitude,
              self.currentLocation.coordinate.longitude);
        */
        locationLabel.text = [NSString stringWithFormat:@" Lat: %+.5f, Lon: %+.5f\n",
                              self.currentLocation.coordinate.latitude,
                              self.currentLocation.coordinate.longitude];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    [logger logErrorWithMessages:@"locationManager didFailWithError: %@", error];
}


-(void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    
    NSLog(@"locationManagerDidPauseLocationUpdates");
}

-(void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager{
    
    NSLog(@"locationManagerDidResumeLocationUpdates");
}









- (IBAction) cameraButtonTapped:(UIButton *)sender {
    
    [self presentImagePicker:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction) photoLibButtonTapped:(UIButton *)sender {
    
    [self presentImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void) presentImagePicker:(UIImagePickerControllerSourceType) sourceType {
    
    if ( sourceType == UIImagePickerControllerSourceTypeCamera  && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [logger logErrorWithMessages:@"device has no camera"];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    };
    
    if ( sourceType != UIImagePickerControllerSourceTypeCamera || [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [logger logDebugWithMessages:@"didFinishPickingMediaWithInfo"];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    currentImage.image = image;
    
    //send captured image and location to the DataManager class
    [[DataManager sharedInstance] saveImage:image withLocation:self.currentLocation];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [logger logDebugWithMessages:@"imagePickerControllerDidCancel"];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
