# Giving Socially - we need to figure out a name for this jams

Lets get this awesome app out there so we can make some paper.

## Build info

There is a preprocessor macro for Release mode and Debug mode. To see what value you are currently set to go into the `Build Settings` tab of your target. Search for `Preprocessor Macros` and you will see the values. `CONFIGURATION_RELEASE=0` is Debug mode and `CONFIGURATION_RELEASE=1` is Release mode. You should only put the app into release mode when building for the app store. You should leave it in debug mode when cutting builds for TestFlight.

Here is how you can set some code to only run in Debug mode or release mode.

	#if CONFIGURATION_RELEASE
	    NSLog(@"\n***************************\nCONFIGURATION MODE: RELEASE\n***************************");
	#elif CONFIGURATOIN_RELEASE == 0
	    NSLog(@"\n***************************\nCONFIGURATION MODE: DEBUG\n***************************");
	#endif