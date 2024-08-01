<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Tutorial

A Flutter package tutorial guide user in the application  

## Usage

```flutter
    //Configuration for the tutorial
    TutorialService.init(padding: const EdgeInsets.all(12),);

    //Add the tutorial widget to the widget tree
    TutorialService.startTutorial(context);
    
    //Add the tutorial to widget you want to show
    Tutorial(
        builder: (context, key) {
        return Text(
                key: key,
                'You have pushed the button this many times:',
            );
        },
        order: 1,
        instruction: 'This is a text field',
        category: 'home',
    ),
```