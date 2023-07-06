# Simple-black-hole-animation 

## Preview is attached below

[![Click here to see the demo video](image_url)](https://drive.google.com/file/d/1yPtpLw-lgb2_PI2hroVpwcvbyOstWV5B/view?usp=drive_link)


## Explanation of Complete Code
The code starts with the main() function, which runs the Flutter application by calling runApp() and passing an instance of MyApp.

MyApp is a stateless widget that defines the root of the application. It returns a MaterialApp with a home of CardHiddenAnimationPage, which represents the main page of the app.

CardHiddenAnimationPage is a stateful widget that defines the main animation page. It manages several animation controllers, tweens, and variables.

The holeSizeTween defines a Tween<double> that animates the size of the hole (black circle) where the card drops. It starts from 0 and ends at 1.5 times the cardSize.

The holeAnimationController is an animation controller that controls the hole's size animation. It listens for changes and updates the state.

The cardOffsetAnimationController controls the animation of the card's offset. It moves the card from its initial position to a new position during the animation.

The cardOffsetTween defines a Tween<double> that animates the card's horizontal offset. It starts from 0 and ends at 2 times the cardSize.

The cardRotationTween defines a Tween<double> that animates the card's rotation. It starts from 0 and ends at 0.5.

The cardElevationTween defines a Tween<double> that animates the card's elevation. It starts from 2 and ends at 20.

The initState() method initializes the animation controllers and adds listeners to update the state when the animations progress.

The dispose() method disposes of the animation controllers to free up resources when the widget is removed from the widget tree.

The build() method constructs the UI for the animation page. It includes a floating action button row at the bottom of the screen.

The first floating action button triggers the animation. When pressed, it forwards the holeAnimationController and cardOffsetAnimationController, which start the animations.

The second floating action button reverses the animation by calling reverse() on both animation controllers.

The body section contains the main animation components. It uses a ClipPath to create the hole shape using the BlackHoleClipper custom clipper.

Inside the Stack, the hole image is displayed using an Image.asset widget. It adjusts its width according to the holeSize obtained from the animation controller.

The HelloWorldCard widget represents the card that drops into the hole. It is wrapped in a Transform.translate and Transform.rotate to handle its position and rotation based on the animation.

The HelloWorldCard widget is a Material with a specified elevation and a BorderRadius.circular shape. Inside, it contains a colored box with centered text that says "Black hole Animation."

The BlackHoleClipper custom clipper class defines the shape of the hole using the getClip() method. It creates an arc from the left side of the screen to the right, forming a circular shape.

That's a summary of the provided code and its animation. When you run the application and press the "Drop" button, the card drops into the hole with a rotation and elevation effect. Pressing the "Add" button reverses the animation, returning the card to its initial position.
