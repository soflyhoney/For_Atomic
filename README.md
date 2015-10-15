PROJECT: Barbie Thumbelina

Please do not share, post or show this interactive or code to anybody. This is for hiring entities of Atomic Object only specifically to show my coding abilities. Thank you!

To see a demo:

Open the index.html in any browser window. The .swf should begin playing. It takes a minute to load the assets into the memory. 

What was challenging about this project:

The most challenging thing about this project was that it was not only due in 4 days but had a lot of animations and a lot of transitions that needed to move and loop seamlessly from scene to scene. In addition, a flash file was handed to me with many loose graphics, animations, timelines and an instruction list that was confusing and difficult to figure out how all the pieces transitioned together and overlapped. This game was embedded in another bigger site so it was very important that I made all the paths relative to the index page that the swf was embedded in. 

Another challenging aspect was setting many event listeners to wait for animations to complete and stop and stagger them before starting new transitions, sounds or scenes or else the entire thing would appear jumpy. This added a lot of work and re-work to get through all of the movement that was going on. Also, the more event listeners you add in flash the more you must remove as to not cause memory leaks. It was difficult to keep track of them all because I was forced to put some code on the timeline in addition to writing code externally due to all the complex overlapped illustrated animations. 

At the end I was required to animate a picture that was custom-colored by the user, and therefore unique every time, and also give the ability to print their unique creation. Both of these functions was somewhat challenging to get to work without issues across all computers and browsers. 

What I did and did not do:
I wrote all of the code for each and every part of this interactive. There is a pre-loader, an intro animation, 2 “games”, a final animation and a final exit screen with calls to action. 

I did not design, plan, animate or script anything on this project. I simply wrote all of the code. 

The code:
To view the source code go into the /Source folder. The core code that I wrote on this project is located in the Source/com/barbie folder. In fact every single file in that folder is code that I wrote to run this project. The .fla file containing the animations also has a limited amount of the code is in the /Source/flash/thumbelina_v8.fla file. 

The main.as class is the top level class that acts as the controller. Most of the event listeners are setup here and this class instructs all of the other objects on how to behave. 

A few animated objects have their own classes to control specific behaviors based on events. These include Bird1.as, Mouth.as and TalkClip.as.

The game1 folder controls the shapes/colors part of the interactive. 

The game2 folder controls the picture coloring part of the interactive. 

For the most part the the class names are relatively obvious as to what they pertain to. 

I tried to keep the code simple and clean and easy to navigate. 

Please let me know if you have any questions. 

