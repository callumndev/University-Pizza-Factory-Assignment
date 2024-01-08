public class Assets
{
  // Game
  public final PImage gameBackground = loadImage("images/basebackground.png");
  public final PImage gameConveyorBelt = loadImage("images/conveyorbelt.png");

  // Ingredients
  public final PImage ingredientDough = loadImage("images/dough.png");


  // Resize images in constructor
  public Assets()
  {
    // Game
    gameBackground.resize(1200, 850); // Resize to fill the whole canvas
    gameConveyorBelt.resize(1200, 250); // Resize to fill bottom 250px of the canvas

    // Ingredients
    ingredientDough.resize(71, 44);
  }
}
