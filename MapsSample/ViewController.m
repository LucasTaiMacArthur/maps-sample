//
//  ViewController.m
//  MapsSample
//
//  Created by Lucas Tai-MacArthur on 6/6/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import "ViewController.h"
#import <UWP/WindowsUIXamlControlsMaps.h>
#import <UWP/WindowsDevicesGeolocation.h>

@interface ViewController ()
@property (strong, nonatomic) UIButton *trafficToggle;
@property (strong, nonatomic) UIButton *overlayToggle;
#ifdef WINOBJC
@property (strong, nonatomic) WUXCMMapControl *map;
@property (strong, nonatomic) UIView *mapView;
#endif

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
    
	double lat = 40.722;
    double lon = -74.001;
	double altitude = 0;

	#ifdef WINOBJC

	WDGBasicGeoposition *NewYork = [[WDGBasicGeoposition alloc] init];
	NewYork.latitude = lat;
    NewYork.longitude = lon;
    NewYork.altitude = altitude;
	WDGGeopoint *newYorkGeopoint = [WDGGeopoint make:NewYork];	
    self.map = [WUXCMMapControl make];
	self.map.center = newYorkGeopoint;
	self.map.zoomLevel = 11;

	CGRect mapFrame = CGRectMake(10, 10, 400, 600);
	self.mapView = [[UIView alloc] initWithFrame:mapFrame];
	[self.mapView setNativeElement:self.map];
	[self.trafficToggle setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:self.mapView];
	#endif

	
    // set layout constraints
    NSDictionary *metrics = @{ @"pad": @80.0, @"margin": @40, @"mapHeight": @350 };
    NSDictionary *views = @{ @"trafficToggle"   : self.trafficToggle,
                             @"overlayToggle"   : self.overlayToggle,
							 @"map"    : self.mapView
                             };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[map(mapHeight)]-[overlayToggle][trafficToggle]"
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
    //self.map.showsTraffic = !self.map.showsTraffic;
	#ifdef WINOBJC
	self.map.trafficFlowVisible = !self.map.trafficFlowVisible;
	#endif


}

- (void)overlayTogglePressed {
    /*if (self.map.mapType == MKMapTypeStandard) {
        self.map.mapType = MKMapTypeHybrid;
    }
    else {
        self.map.mapType = MKMapTypeStandard;
    }*/

	#ifdef WINOBJC
	if (self.map.style == WUXCMMapStyleRoad) {
	    self.map.style = WUXCMMapStyleAerialWithRoads;
	}
	else {
	    self.map.style = WUXCMMapStyleRoad;
	}
	#endif
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

#ifdef WINOBJC
// Tell the WinObjC runtime how large to render the application (From github.com/Microsoft/WinObjC/samples/HelloUI)
@implementation UIApplication (UIApplicationInitialStartupMode)
+ (void)setStartupDisplayMode:(WOCDisplayMode*)mode {
    mode.autoMagnification = TRUE;
    mode.sizeUIWindowToFit = TRUE;
    mode.fixedWidth = 0;
    mode.fixedHeight = 0;
    mode.magnification = 1.0;
}
@end
#endif
