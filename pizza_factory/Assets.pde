public class Assets
{
  // Game
  public final PImage gameBackground = loadImage("images/game/background.png");
  public final PImage gameConveyorBelt = loadImage("images/game/conveyorbelt.png");


  // Resize images in constructor
  public Assets()
  {
    // Game
    gameBackground.resize(1200, 850); // Resize to fill the whole canvas
    gameConveyorBelt.resize(1200, 250); // Resize to fill bottom 250px of the canvas
  }
}
