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
  }
}
