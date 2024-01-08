import java.util.HashMap;
import java.util.Map;
import java.util.Arrays;

public enum Ingredient {
  DOUGH,
    TOMATO_SAUCE,
    BBQ_SAUCE,
    CHEESE,
    CHICKEN,
    ONION,
    MUSHROOM,
    HAM,
    PINEAPPLE;
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

  HashMap<Ingredient, Map.Entry<IngredientBoundType, ArrayList<Float>>> ingredientPickupBounds = new HashMap<>() {
    {
      put(Ingredient.DOUGH, new SimpleEntry(IngredientBoundType.RECTANGLE, new ArrayList<Float>(Arrays.asList(7.0f, 499.0f, 117.0f, 79.0f))));
      put(Ingredient.TOMATO_SAUCE, new SimpleEntry(IngredientBoundType.ELLIPSE, new ArrayList<Float>(Arrays.asList(152.0f, 537.0f, 38.0f, 38.0f))));
      put(Ingredient.BBQ_SAUCE, new SimpleEntry(IngredientBoundType.ELLIPSE, new ArrayList<Float>(Arrays.asList(191.0f, 560.0f, 38.0f, 38.0f))));
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

    // LEFT mouse was just clicked
    if (mousePressed && !this.prevMouseDown && mouseButton == LEFT)
    {
      this.prevMouseDown = true;
      this.onIngredientClick();
    }
    // Mouse is currently not pressed, but was before
    else if (!mousePressed && this.prevMouseDown)
    {
      this.prevMouseDown = false;
      this.onIngredientRelease();
    }

    if (this.game.enableDebug)
    {
      // Draw the bounds that you can click in to pickup an ingredient
      this.drawIngredientPickupBounds();
    }


    if (this.isDragging)
    {
      ellipse(mouseX, mouseY, 10, 10);
    }
  }


  private void onIngredientClick()
  {
    this.isDragging = true;
  }

  private void onIngredientRelease()
  {
    this.isDragging = false;
  }


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
