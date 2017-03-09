//
//  SVAnnotation.h
//  CustomMap
//
//  Created by Sam Vermette on 04.03.13.
//  Copyright (c) 2013 Sam Vermette. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface SVAnnotation : NSObject <BMKAnnotation>

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
