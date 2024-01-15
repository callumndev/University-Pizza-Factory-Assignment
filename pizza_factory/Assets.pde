public class Assets
{
  // Game
  public final PImage gameBackground = loadImage("images/game/background.png");
  public final PImage gameConveyorBelt = loadImage("images/game/conveyorbelt.png");

  // Ingredients
  public final PImage ingredientDough = loadImage("images/ingredients/dough.png");
  //public final PImage ingredientTomatoSauce = loadImage("images/ingredients/tomato_sauce.png");
  //public final PImage ingredientBBQSauce = loadImage("images/ingredients/bbq_sauce.png");
  public final PImage ingredientCheese = loadImage("images/ingredients/cheese.png");
  public final PImage ingredientChicken = loadImage("images/ingredients/chicken.png");
  public final PImage ingredientOnion = loadImage("images/ingredients/onion.png");
  public final PImage ingredientMushroom = loadImage("images/ingredients/mushroom.png");
  public final PImage ingredientHam = loadImage("images/ingredients/ham.png");
  public final PImage ingredientPineapple = loadImage("images/ingredients/pineapple.png");

  // Toppings
  public final PImage toppingDoughRolled = loadImage("images/ingredients/toppings/dough_rolled.png");


  // Resize images in constructor
  public Assets()
  {
    // Game
    gameBackground.resize(1200, 850); // Resize to fill the whole canvas
    gameConveyorBelt.resize(1200, 250); // Resize to fill bottom 250px of the canvas

    // Ingredients
    ingredientDough.resize(71, 44);
    //ingredientTomatoSauce.resize();
    //ingredientBBQSauce.resize();
    ingredientCheese.resize(31, 25);
    ingredientChicken.resize(22, 35);
    ingredientOnion.resize(25, 29);
    ingredientMushroom.resize(15, 24);
    ingredientHam.resize(46, 31);
    ingredientPineapple.resize(11, 21);

    // Toppings
    toppingDoughRolled.resize(53+150, 43+150);
  }
}
