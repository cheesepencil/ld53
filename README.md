# Ludum Dare 52 - Delivery
https://ldjam.com/events/ludum-dare/53

# Bundle Dumper: Florida Edition 
Hurl babies through five exciting levels (including a tutorial level) in this flappy inspired side scroller with a Floridian twist! Also my first complete PICO-8 game, so now you've been warned.

## Controls
It's a PICO-8 game, you get what you get and you don't get much:
* left and right arrows to change direction
* `Z` is the circle button (`C` on keyboards that nobody uses in Florida)
* `X` is the cross button (`V` on keyboards that nobody uses in Florida)
* But save yourself the wrist strain and just use a gamepad/controller!!!

## Mechanics
* Flapping increases vertical AND horizontal momentum (that is, flapping while turning changes your direction *faster*)
* Aim your delivery by holding down the cross button but keep in mind you can't flap or turn while aiming
* Once you've started aiming, you're committed. Release the cross button to drop the baby from your beak
* If you hurl a baby and miss, you can get another one from the hot air balloon at the beginning of the level - don't worry, you can't run out
* ...even if you don't miss, on levels with multiple deliveries you will have to go back to the hot air balloon to get more babies!

## Hazards
* Think you can cheese the game by camping at the top of the screen? Think again! THE MERCILESS FLORIDA SUN WILL BURN YOU TO TOAST
* Think you can cheese the game by camping at the bottom of the screen? Think again! THE MERCILESS FLORIDA ALLIGATORS WILL CHEW YOU UP LIKE BUBBLEGUM
* Well armed Floridians will shoot you
* Cleverly placed drones will shred you

## Speedrunning Notes
* The timer starts when the first level loads and ends when you see your final time displayed on the "YOU WIN!" screen.
* Strategic deaths will get you back to the hot air balloon faster but if you run out of lives and then continue all your deliveries in the current level will be reset.
* regrettably the timer is only precise to seconds (I ran out of time! I barely had time to add sound effects!)

# My personal best time is 5 minutes and 31 seconds - **I DARE anyone to do better and post a screenshot in the comments!**

## Apologies in Advance
* Hit detection is a little off... it was my first time writing my own AABB collision detection and while I've done my best sometimes there are deaths that look cheap.
* The aiming trajectory thing is largely accurate when you're moving right, and off by six pixels or so when the player is moving left. At least the clumsy hit detection works to your advantage here.