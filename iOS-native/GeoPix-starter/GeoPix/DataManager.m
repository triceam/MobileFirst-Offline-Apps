//
//  DataManager.m
//  GeoPix
//
//  Created by Andrew Trice on 3/13/15.
//  Copyright (c) 2015 Andrew Trice. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager


+(DataManager*) sharedInstance {
    
    static DataManager *instance = nil;
    DataManager *strongInstance = instance;
    
    @synchronized(self) {
        if (strongInstance == nil) {
            strongInstance = [[[self class] alloc] init];
            instance = strongInstance;
        }
    }
    
    return strongInstance;
}



-(id) init {
    
    self = [super init];
    
    if ( self ) {
        logger = [IMFLogger loggerForName:NSStringFromClass([self class])];
        [logger logDebugWithMessages:@"initializing local datastore 'geopix'..."];
        
        //setup the local data store
        /*
        // initialize an instance of the IMFDataManager
        self.manager = [IMFDataManager sharedInstance];
        
        NSError *error = nil;
        
        //create a local data store
        self.datastore = [self.manager localStore:@"geopix" error:&error];
        
        if (error) {
            [logger logErrorWithMessages:@"Error creating local data store %@",error.description];
        }
         */
        
        
        //create a remote data store
        /*
        [self.manager remoteStore:@"geopix" completionHandler:^(CDTStore *store, NSError *error) {
            if (error) {
                [logger logErrorWithMessages:@"Error creating remote data store %@",error.description];
            } else {
                
                //assign user permissions
                [self.manager setCurrentUserPermissions:DB_ACCESS_GROUP_MEMBERS forStoreName:@"geopix" completionHander:^(BOOL success, NSError *error) {
                    if (error) {
                        [logger logErrorWithMessages:@"Error setting permissions for user with error %@",error.description];
                    }
         
                     
                    //start replication process
                    //[self replicate];
                }];
            }
        }];
         */
    }
    
    return self;
}



-(void) saveImage:(UIImage*)image withLocation:(CLLocation*)location {
    
    [logger logDebugWithMessages:@"saveImage withLocation"];
    
    //save in background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
       
        [logger logDebugWithMessages:@"creating document..."];
        
        NSDate *now = [NSDate date];
        NSString *dateString = [NSDateFormatter localizedStringFromDate:now
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterFullStyle];
        /*
        // Create a document
        CDTMutableDocumentRevision *rev = [CDTMutableDocumentRevision revision];
        rev.body = @{
                     @"sort": [NSNumber numberWithDouble:[now timeIntervalSince1970]],
                     @"clientDate": dateString,
                     @"latitude": [NSNumber numberWithFloat:location.coordinate.latitude],
                     @"longitude": [NSNumber numberWithFloat:location.coordinate.longitude],
                     @"altitude": [NSNumber numberWithFloat:location.altitude],
                     @"course": [NSNumber numberWithFloat:location.course],
                     @"type": @"com.geopix.entry"
                     };
        
        
        
        [logger logDebugWithMessages:@"creating image attachment..."];
        
        //create the image filename and save to a temporary path
        NSDate *date = [NSDate date];
        NSString *imageName = [NSString stringWithFormat:@"image%f.jpg", [date timeIntervalSince1970]];
        
        NSString *tempDirectory = NSTemporaryDirectory();
        NSString *imagePath = [tempDirectory stringByAppendingPathComponent:imageName];
        
        [logger logDebugWithMessages:@"saving image to temporary location: %@", imagePath];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        [imageData writeToFile:imagePath atomically:YES];
        
        //create a new attachment
        CDTUnsavedFileAttachment *att1 = [[CDTUnsavedFileAttachment alloc]
                                          initWithPath:imagePath
                                          name:imageName
                                          type:@"image/jpeg"];
        
        //add attachment to the document revision
        rev.attachments = @{ imageName: att1 };
        
        //save the attachment to the local data store
        [self.datastore save:rev completionHandler:^(id savedObject, NSError *error) {
            if(error) {
                [logger logErrorWithMessages:@"Error creating document: %@", error.localizedDescription];
            }
            [logger logDebugWithMessages:@"Document created: %@", savedObject];
        }];
         
         */
        
        //[self replicate];
        
    });
}


-(void) replicate {
    
    if ( self.replicator == nil ) {
        [logger logDebugWithMessages:@"attempting replication to remote datastore..."];
        
        __block NSError *replicationError;
        
        /*
        //create push replication and create the replicator
        CDTPushReplication *push = [self.manager pushReplicationForStore: @"geopix"];
        self.replicator = [self.manager.replicatorFactory oneWay:push error:&replicationError];
        
        if(replicationError){
            // Handle error if one happens
            [logger logErrorWithMessages:@"An error occurred: %@", replicationError.localizedDescription];
        }
        
        self.replicator.delegate = self;
        
        replicationError = nil;
        [logger logDebugWithMessages:@"starting replication"];
        
        //start replication
        [self.replicator startWithError:&replicationError];
        if(replicationError){
            [logger logErrorWithMessages:@"An error occurred: %@", replicationError.localizedDescription];
        }else{
            [logger logDebugWithMessages:@"replication start successful"];
        }
         */
        
    }
    else {
        [logger logDebugWithMessages:@"replicator already running"];
    }
}


//CDTReplicatorDelegate Methods
/*
- (void)replicatorDidChangeState:(CDTReplicator *)replicator {
    [logger logDebugWithMessages:@"Replicator changed State: %@", [CDTReplicator stringForReplicatorState:replicator.state]];
}

- (void)replicatorDidChangeProgress:(CDTReplicator *)replicator {
    [logger logDebugWithMessages:@"Replicator progress: %d/%d", replicator.changesProcessed, replicator.changesTotal];
    
    NSDictionary *userInfo = @{ @"status":[NSString stringWithFormat:@"%d/%d", replicator.changesProcessed, replicator.changesTotal] };
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ReplicationStatus"
     object:self
     userInfo:userInfo];
}

- (void)replicatorDidError:(CDTReplicator *)replicator info:(NSError *)info {
    [logger logErrorWithMessages:@"An error occurred: %@", info.localizedDescription];
    self.replicator = nil;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ReplicationError"
     object:self];
}

- (void)replicatorDidComplete:(CDTReplicator *)replicator {
    [logger logDebugWithMessages:@"Replication completed"];
    self.replicator = nil;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ReplicationComplete"
     object:self];
}
*/

-(void) getLocalData:(void (^)(NSArray *results, NSError *error)) completionHandler {
    
    /*
    NSPredicate *queryPredicate = [NSPredicate predicateWithFormat:@"(type = 'com.geopix.entry')"];
    CDTCloudantQuery *query = [[CDTCloudantQuery alloc] initWithPredicate:queryPredicate];
    
    [self.datastore performQuery:query completionHandler:^(NSArray *results, NSError *error) {
        
        completionHandler( results, error );
    }];
     */
}

@end
