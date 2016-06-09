//
//  ViewController.m
//  MapsSample
//
//  Created by Lucas Tai-MacArthur on 6/6/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIButton *trafficToggle;
@property (strong, nonatomic) UIButton *overlayToggle;
@property (strong, nonatomic) MKMapView *map;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up traffic toggle button
    self.trafficToggle = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.trafficToggle setTitle:@"Toggle Traffic"
                   forState:UIControlStateNormal];
    [self.trafficToggle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.trafficToggle addTarget:self
                           action:@selector(trafficTogglePressed)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.trafficToggle];
    
    // set up overlay toggle button
    self.overlayToggle = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.overlayToggle setTitle:@"Toggle Overlay"
                        forState:UIControlStateNormal];
    [self.overlayToggle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.overlayToggle addTarget:self
                           action:@selector(overlayTogglePressed)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.overlayToggle];
    
    // set up the mapview with New York map center
    float lat = 40.722;
    float lon = -74.001;
    CLLocationDistance radiusMeters = 10000;
    CLLocationCoordinate2D newYorkGeopoint = CLLocationCoordinate2DMake(lat, lon);
    MKCoordinateRegion mapCenter = MKCoordinateRegionMakeWithDistance(newYorkGeopoint, radiusMeters, radiusMeters);
    
    self.map = [[MKMapView alloc] init];
    [self.map setRegion:mapCenter animated:YES];
    [self.map setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.map];

    // set layout constraints
    NSDictionary *metrics = @{ @"pad": @80.0, @"margin": @40, @"mapHeight": @400 };
    NSDictionary *views = @{ @"trafficToggle"   : self.trafficToggle,
                             @"overlayToggle"   : self.overlayToggle,
                             @"map"   : self.map
                             };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[map(mapHeight)]-[overlayToggle][trafficToggle]"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[overlayToggle]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[trafficToggle]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[map]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    
    
    
}

- (void)trafficTogglePressed {
    self.map.showsTraffic = !self.map.showsTraffic;

}

- (void)overlayTogglePressed {
    if (self.map.mapType == MKMapTypeStandard) {
        self.map.mapType = MKMapTypeHybrid;
    }
    else {
        self.map.mapType = MKMapTypeStandard;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
