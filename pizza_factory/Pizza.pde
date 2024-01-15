class Pizza extends RenderObject
{
  private Integer xPos;
  private Integer yPos;

  private ArrayList<Ingredient> toppings = new ArrayList<>();


  public Pizza(PizzaGame game)
  {
    super(game);
    this.resetPosition(); // Set initial position to the right of the screen
  }


  public void style()
  {
    imageMode(CENTER);
  }

  public void render()
  {
    // Draw dough base
    image(this.assets.toppingDoughRolled, this.xPos, this.yPos);

    // Update X position to the left
    this.xPos -= this.game.background.getBeltSpeedValue();

    // Pizza has gone of the screen
    if (this.xPos <= -this.assets.toppingDoughRolled.width)
    {
      this.onPizzaEnd();
    }
  }


  // Reset the position of the pizza to the right of the screen (off screen)
  private void resetPosition()
  {
    this.xPos = width + (this.assets.toppingDoughRolled.width / 2);
    this.yPos = (height - this.assets.gameConveyorBelt.height) + (this.assets.gameConveyorBelt.height / 2);
  }


  // Called when the pizza goes off the screen to the left
  private void onPizzaEnd()
  {
    // Reset position to the right
    this.resetPosition();
  }

  // Called when an ingredient should be added to the pizza
  private void onPizzaIngredientAdd(Ingredient ingredient)
  {
    // Add ingredient as a topping to the pizza
    this.toppings.add(ingredient);

    // Debug
    println("ADD topping " + ingredient + " | " + toppings);
  }
}
