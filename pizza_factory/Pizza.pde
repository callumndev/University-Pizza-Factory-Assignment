import java.util.Random;

class Pizza extends RenderObject
{
  private Integer xPos;
  private Integer yPos;

  private ArrayList<Ingredient> requiredToppings = new ArrayList<>();
  private ArrayList<Ingredient> toppings = new ArrayList<>();

  private Boolean locked = false;
  public Integer mistakes = 0;
  public Integer completed = 0;


  public Pizza(PizzaGame game)
  {
    super(game);
    this.resetPosition(); // Set initial position to the right of the screen
    this.addRandomToppings(); // Set initial toppings
  }


  public void style()
  {
    imageMode(CENTER);
  }

  public void render()
  {
    // Draw dough base
    image(this.assets.doughRolled, this.xPos, this.yPos);

    // Update X position to the left
    this.xPos -= this.game.background.getBeltSpeedValue();

    // Draw pizza toppings
    this.renderIngredients();

    // Pizza has gone of the screen
    if (this.xPos <= -this.assets.doughRolled.width)
    {
      this.onPizzaEnd();
    }
  }


  // Reset the position of the pizza to the right of the screen (off screen)
  private void resetPosition()
  {
    this.xPos = width + (this.assets.doughRolled.width / 2);
    this.yPos = (height - this.assets.gameConveyorBelt.height) + (this.assets.gameConveyorBelt.height / 2);
  }

  private void renderIngredients()
  {
    for (int i = 0; i < this.toppings.size(); i++) {
      // Get topping image
      Ingredient topping = this.toppings.get(i);
      PImage toppingImage = this.game.ingredients.getPickupIngredientImage(topping);
      if (toppingImage == null)
        continue;

      // Draw toppings
      Integer count = 3; // How many of this topping to draw

      for (int j = 0; j < count; j++)
      {
        Integer x = 0;
        Integer y = 0;

        switch (topping)
        {

          //case TOMATO_SAUCE:
          //return this.assets.ingredientTomatoSauce;

          //case BBQ_SAUCE:
          //  return this.assets.ingredientBBQSauce;

        case CHEESE:
          if (j == 0)
          {
            x = this.xPos - 40;
            y = this.yPos - 35;
          } else if (j == 1)
          {
            x = this.xPos + 50;
            y = this.yPos;
          } else if (j == 2)
          {
            x = this.xPos;
            y = this.yPos + 50;
          }
          break;

        case CHICKEN:
          if (j == 0)
          {
            x = this.xPos - 10;
            y = this.yPos - 50;
          } else if (j == 1)
          {
            x = this.xPos + 60;
            y = this.yPos + 35;
          } else if (j == 2)
          {
            x = this.xPos - 30;
            y = this.yPos + 50;
          }
          break;

        case ONION:
          if (j == 0)
          {
            x = this.xPos + 55;
            y = this.yPos - 30;
          } else if (j == 1)
          {
            x = this.xPos - 30;
            y = this.yPos + 20;
          }
          break;

        case MUSHROOM:
          if (j == 0)
          {
            x = this.xPos + 25;
            y = this.yPos;
          } else if (j == 1)
          {
            x = this.xPos - 50;
            y = this.yPos + 40;
          } else if (j == 2)
          {
            x = this.xPos + 40;
            y = this.yPos + 60;
          }
          break;

        case HAM:
          if (j == 0)
          {
            x = this.xPos - 50;
            y = this.yPos - 5;
          } else if (j == 1)
          {
            x = this.xPos + 30;
            y = this.yPos + 28;
          }
          break;

        case PINEAPPLE:
          if (j == 0)
          {
            x = this.xPos + 25;
            y = this.yPos - 40;
          } else if (j == 1)
          {
            x = this.xPos - 10;
            y = this.yPos;
          }
          break;

        default:
          x = this.xPos - (int) random(-10, 10);
          y = this.yPos;
          break;
        }


        // Draw topping
        image(toppingImage, x, y);
      }
    }

    // If pizza is locked (un-editable)
    if (this.locked)
    {
      pushMatrix();

      // Set the stroke color to red
      stroke(255, 0, 0);

      // Move the origin to the specified center
      translate(this.xPos, this.yPos);

      // Rotate by 45 degrees (PI/4 radians) to create an X
      rotate(PI / 4);

      // Draw the first line of the X
      line(-100, 0, 100, 0);

      // Draw the second line of the X
      line(0, -100, 0, 100);

      popMatrix();
    }
  }


  private void addRandomToppings()
  {
    addRandomToppings(2); // Default
  }

  private void addRandomToppings(Integer amount)
  {
    for (int i = 0; i < amount; i++)
    {
      // Get ingredient enum values
      Ingredient[] ingredients = Ingredient.values();

      // Get random ingredient
      Random random = new Random();
      Ingredient randomIngredient = ingredients[random.nextInt(ingredients.length)];

      // Add topping
      this.requiredToppings.add(randomIngredient);
    }
  }


  // Called when the pizza goes off the screen to the left
  private void onPizzaEnd()
  {
    this.unlock();

    // Check mistake
    Boolean isCompleted = this.toppings.equals(this.requiredToppings);
    if (!isCompleted)
    {
      this.mistakes++;
    }

    // Clear toppings
    this.requiredToppings.clear();
    this.toppings.clear();

    // Add new random toppings
    this.addRandomToppings();

    // Reset position to the right
    this.resetPosition();

    // If too many mistakes happened
    if (this.mistakes >= this.game.maxMistakes)
    {
      this.game.gameOver = true;
      return;
    }
  }

  // Called when an ingredient should be added to the pizza
  private void onPizzaIngredientAdd(Ingredient ingredient)
  {
    if (this.locked)
      return;

    // Add ingredient as a topping to the pizza
    this.toppings.add(ingredient);

    // Check mistake
    Boolean isMistake = !this.requiredToppings.contains(ingredient);
    if (isMistake)
    {
      this.lock();
    }

    // Check if the pizza is complete
    Boolean isCompleted = this.toppings.equals(this.requiredToppings);
    if (isCompleted)
    {
      this.lock();
      this.completed++;
      println("completed");
    }
  }

  // Makes the pizza un-editable and speeds up the belt so it goes to the end quicker
  private void lock() {
    this.locked = true;
    this.game.background.setBeltSpeed(BeltSpeed.FAST);
  }

  // Makes the pizza editable and returns the belt speed to normal
  private void unlock() {
    this.locked = false;
    this.game.background.setBeltSpeed(BeltSpeed.SLOW);
  }
}
