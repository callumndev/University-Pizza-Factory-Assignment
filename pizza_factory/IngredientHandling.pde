import java.util.HashMap;
import java.util.Map;
import java.util.Arrays;

public enum Ingredient {
  // TOMATO_SAUCE,
  //   BBQ_SAUCE,
    CHEESE,
    CHICKEN,
    ONION,
    MUSHROOM,
    HAM,
    PINEAPPLE,

    PIZZA; // Only used to visualising pizza bounds in debug mode - can't pick things up from these bounds
}

public enum IngredientBoundType {
  ELLIPSE,
    SQUARE,
    RECTANGLE;
}

class IngredientHandling extends RenderObject
{
  private Boolean prevMouseDown = false;
  private Boolean isDragging = false;
  private Ingredient activeIngredient = null;
  private PImage activeIngredientImage = null;


  HashMap<Ingredient, Map.Entry<IngredientBoundType, ArrayList<Float>>> ingredientPickupBounds = new HashMap<>() {
    {
      //put(Ingredient.TOMATO_SAUCE, new SimpleEntry(IngredientBoundType.ELLIPSE, new ArrayList<Float>(Arrays.asList(152.0f, 537.0f, 38.0f, 38.0f))));
      //put(Ingredient.BBQ_SAUCE, new SimpleEntry(IngredientBoundType.ELLIPSE, new ArrayList<Float>(Arrays.asList(191.0f, 560.0f, 38.0f, 38.0f))));
      put(Ingredient.CHEESE, new SimpleEntry(IngredientBoundType.RECTANGLE, new ArrayList<Float>(Arrays.asList(232.0f, 500.0f, 155.0f, 79.0f))));
      put(Ingredient.CHICKEN, new SimpleEntry(IngredientBoundType.RECTANGLE, new ArrayList<Float>(Arrays.asList(393.0f, 500.0f, 155.0f, 79.0f))));
      put(Ingredient.ONION, new SimpleEntry(IngredientBoundType.RECTANGLE, new ArrayList<Float>(Arrays.asList(554.0f, 500.0f, 155.0f, 79.0f))));
      put(Ingredient.MUSHROOM, new SimpleEntry(IngredientBoundType.RECTANGLE, new ArrayList<Float>(Arrays.asList(715.0f, 500.0f, 155.0f, 79.0f))));
      put(Ingredient.HAM, new SimpleEntry(IngredientBoundType.RECTANGLE, new ArrayList<Float>(Arrays.asList(876.0f, 500.0f, 155.0f, 79.0f))));
      put(Ingredient.PINEAPPLE, new SimpleEntry(IngredientBoundType.RECTANGLE, new ArrayList<Float>(Arrays.asList(1037.0f, 500.0f, 155.0f, 79.0f))));
    }
  };


  public IngredientHandling(PizzaGame game)
  {
    super(game);
  }


  public Boolean getShouldRender()
  {
    return true;
  }

  public void render()
  {
    // If the games debug mode is enabled
    if (this.game.enableDebug)
    {
      // Add current pizza bounds
      ingredientPickupBounds.put(
        Ingredient.PIZZA,
        Map.entry(
          IngredientBoundType.ELLIPSE,
          new ArrayList<Float>(Arrays.asList(
            (float)this.game.pizza.xPos,
            (float)this.game.pizza.yPos,
            (float)this.assets.doughRolled.width,
            (float)this.assets.doughRolled.height)
          ))
        );

      // Draw the bounds that you can click in to pickup an ingredient
      this.drawIngredientPickupBounds();

      // Remove to re-add next frame
      ingredientPickupBounds.remove(Ingredient.PIZZA);
    }


    // LEFT mouse was just clicked
    if (mousePressed && !this.prevMouseDown && mouseButton == LEFT)
    {
      this.prevMouseDown = true;

      Ingredient clickedIngredient = this.getClickedIngredient(Float.valueOf(mouseX), Float.valueOf(mouseY));
      if (clickedIngredient != null)
      {
        this.onIngredientClick(clickedIngredient);
      }
    }
    // Mouse is currently not pressed, but was before
    else if (!mousePressed && this.prevMouseDown)
    {
      this.prevMouseDown = false;
      this.onIngredientRelease();
    }


    // If we are dragging a valid ingredient
    if (this.isDragging && this.activeIngredient != null)
    {
      image(
        // Current active ingredient
        this.activeIngredientImage,
        // Centered under mouse pos
        mouseX - this.activeIngredientImage.width / 2,
        mouseY - this.activeIngredientImage.height / 2
        );

      // Check if the mouse position is inside of the pizza bounds
      Boolean isCollidingWithPizza = this.gameUtils.isPointInsideEllipse(
        // Current mouse position
        (float)mouseX, (float)mouseY,

        // Pizza position + width and size
        (float)this.game.pizza.xPos, (float)this.game.pizza.yPos,
        (float)this.assets.doughRolled.width, (float)this.assets.doughRolled.height
        );

      // User is trying to add the active ingredient as a pizza topping
      if (isCollidingWithPizza)
      {
        // Call method for adding ingredient to the pizza for this active ingredient
        this.game.pizza.onPizzaIngredientAdd(this.activeIngredient);

        // Call ingredient release to "drop" the ingredient
        this.onIngredientRelease();
      }
    }
  }


  private void onIngredientClick(Ingredient clickedIngredient)
  {
    // Set image for active ingredient if valid
    PImage pickedupIngredientImage = this.getPickupIngredientImage(clickedIngredient);
    if (pickedupIngredientImage != null)
    {
      this.activeIngredient = clickedIngredient;
      this.activeIngredientImage = pickedupIngredientImage;
    }

    // Set cursor to hand
    cursor(HAND);

    // Display as dragging
    this.isDragging = true;
  }

  private void onIngredientRelease()
  {
    // Disable dragging of current ingredient
    this.isDragging = false;

    // Reset active ingredient
    this.activeIngredient = null;
    this.activeIngredientImage = null;

    // Reset cursor
    cursor(ARROW);
  }


  // If the user clicks inside of the bounds of an ingredient pickup area then this returns which ingredient, else returns null for no ingredient clicked
  private Ingredient getClickedIngredient(Float pointX, Float pointY)
  {
    for (Map.Entry<Ingredient, Map.Entry<IngredientBoundType, ArrayList<Float>>> ingredientPickupBoundsEntry : ingredientPickupBounds.entrySet()) {
      Ingredient ingredient = ingredientPickupBoundsEntry.getKey();

      // Unpack bounds info entry
      Map.Entry<IngredientBoundType, ArrayList<Float>> ingredientPickupBoundsInfoEntry = ingredientPickupBoundsEntry.getValue();
      IngredientBoundType boundsType = ingredientPickupBoundsInfoEntry.getKey(); // circle, square, rectangle, etc
      ArrayList<Float> boundsMetadata = ingredientPickupBoundsInfoEntry.getValue(); // x, y, width, height etc of the bounds area

      // Unpack x, y, width, height
      Float x = boundsMetadata.get(0);
      Float y = boundsMetadata.get(1);
      Float boundsWidth = boundsMetadata.get(2);
      Float boundsHeight = boundsMetadata.get(3);

      // Check if mouse pos is inside of the ingredient pickup bounds, also account for bounds shape
      if (boundsType == IngredientBoundType.RECTANGLE)
      {
        Boolean isInsideRectBounds = this.gameUtils.isPointInsideRect(pointX, pointY, x, y, boundsWidth, boundsHeight);
        if (isInsideRectBounds)
        {
          return ingredient;
        }
      } else if (boundsType == IngredientBoundType.ELLIPSE)
      {
        Boolean isInsideEllipseBounds = this.gameUtils.isPointInsideEllipse(pointX, pointY, x, y, boundsWidth, boundsHeight);
        if (isInsideEllipseBounds)
        {
          return ingredient;
        }
      }
    }

    return null;
  }

  // Gets the image for when the coresponding ingredient is picked up
  public PImage getPickupIngredientImage(Ingredient ingredient)
  {
    switch (ingredient)
    {
      //case TOMATO_SAUCE:
      //return this.assets.ingredientTomatoSauce;

      //case BBQ_SAUCE:
      //  return this.assets.ingredientBBQSauce;

    case CHEESE:
      return this.assets.ingredientCheese;

    case CHICKEN:
      return this.assets.ingredientChicken;

    case ONION:
      return this.assets.ingredientOnion;

    case MUSHROOM:
      return this.assets.ingredientMushroom;

    case HAM:
      return this.assets.ingredientHam;

    case PINEAPPLE:
      return this.assets.ingredientPineapple;

    default:
      return null;
    }
  }

  // Debug - Draws the boundaries which users can click in to pick ingredients up, usually invisible
  private void drawIngredientPickupBounds()
  {
    for (Map.Entry<Ingredient, Map.Entry<IngredientBoundType, ArrayList<Float>>> ingredientPickupBoundsEntry : ingredientPickupBounds.entrySet()) {
      Ingredient ingredient = ingredientPickupBoundsEntry.getKey();

      // Unpack bounds info entry
      Map.Entry<IngredientBoundType, ArrayList<Float>> ingredientPickupBoundsInfoEntry = ingredientPickupBoundsEntry.getValue();
      IngredientBoundType boundsType = ingredientPickupBoundsInfoEntry.getKey(); // circle, square, rectangle, etc
      ArrayList<Float> boundsMetadata = ingredientPickupBoundsInfoEntry.getValue(); // x, y, width, height etc of the bounds area

      pushStyle();

      color boundsLabelColor = color(255, 255, 0, 255);
      fill(color(118, 185, 0, 150));

      // Draw ingredient pickup bounds
      switch (boundsType)
      {
      case ELLIPSE:
        {
          if (boundsMetadata.size() != 4)
            break;

          // Unpack x, y, width, height
          Float x = boundsMetadata.get(0);
          Float y = boundsMetadata.get(1);
          Float boundsWidth = boundsMetadata.get(2);
          Float boundsHeight = boundsMetadata.get(3);

          // Draw circle
          ellipse(x, y, boundsWidth, boundsHeight);


          fill(boundsLabelColor);
          text(
            ingredient.toString(),
            x-(textWidth(ingredient.toString())/2),
            y+(this.game.textUtils.getTextHeight()/2)
            );
        }
        break;

      case RECTANGLE:
        {
          if (boundsMetadata.size() != 4)
            break;

          // Unpack x, y, width, height
          Float x = boundsMetadata.get(0);
          Float y = boundsMetadata.get(1);
          Float boundsWidth = boundsMetadata.get(2);
          Float boundsHeight = boundsMetadata.get(3);

          // Draw square
          rect(x, y, boundsWidth, boundsHeight);

          fill(boundsLabelColor);
          text(
            ingredient.toString(),
            x+(boundsWidth/2)-(textWidth(ingredient.toString())/2),
            y+(boundsHeight/2)+(this.game.textUtils.getTextHeight()/2)
            );
        }
        break;

      default:
        System.out.println("Drawing ingredient pickup bounds for type '" + boundsType + "' is unimplemented");
        break;
      }

      popStyle();
    }
  }
}
