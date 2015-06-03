# PixelPerfect
Compare mockup design with a user interface on iOS


##Features
* show mockup image to compare with a user interface
* change the mockup image transparency
* invert colors

##Usage

Create dictionary with class name and corresponding mockup image name.

```
    NSDictionary *classesImagesDictionary = @{ NSStringFromClass([ExampleViewController class]) : @"add-point.png" };
    [[PIXELPerfect shared] setControllersClassesAndImages:classesImagesDictionary];
```