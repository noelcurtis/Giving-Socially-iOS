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
	
## Genereating Models

We use mogenerator to generate the models. The machine files are put into ```Code/Models/Machine``` and human files are put into ```Code/Models```.

#### Install Mogenerator

You can read about mogenerator at http://rentzsch.github.com/mogenerator/

```brew install mogenerator```

#### Generate Models

__Via Target__: Simply __build__ the __*GenerateModels*__ target and new _Machine files will be generated from your model.

__Via CLI__: In the project root run
	
```mogenerator --model Resources/App/GSDataModel.xcdatamodeld/GSDataModel.xcdatamodel --machine-dir Code/Models/Machine --human-dir Code/Models```