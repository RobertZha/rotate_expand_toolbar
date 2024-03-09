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

TODO: Rotate expand toolbar.

## Features

TODO: A set of icon buttons that can be rotated and expanded.


## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
    Stack(
        children: [
            RotateExpandToolbar(
                expandDuration: const Duration(milliseconds: 500),
                color: Colors.blue,
                iconSize: 24,
                children: [
                    RotateExpandToolbarItem(
                        icon: Icons.play_circle_outline_outlined,
                        color: Colors.amber,
                        onTap: () {},
                    ),
                    RotateExpandToolbarItem(
                        icon: Icons.circle_notifications_outlined,
                        color: Colors.green,
                        onTap: () {},
                    ),
                    RotateExpandToolbarItem(
                        icon: Icons.flag_circle_outlined,
                        color: Colors.red,
                        onTap: () {},
                    ),
                    RotateExpandToolbarItem(
                        icon: Icons.add_shopping_cart_outlined,
                        tooltip: "Shopping Cart",
                        onTap: () {},
                    ),
                ],
            )
        ],
    )
```
