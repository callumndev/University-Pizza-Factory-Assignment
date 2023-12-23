import java.util.Map;
import java.util.LinkedHashMap;

public enum BeltSpeed {
  OFF,
    SLOW,
    FAST;
}

class Background extends RenderObject
{
  private PImage baseBackgroundImage;
  private Integer backgroundX = 0;

  private PImage conveyorBeltImage;
  private BeltSpeed beltSpeed = BeltSpeed.SLOW;


  public Background(PizzaGame game)
  {
    super(game);

    this.loadImages(); // Load all images
  }

  // Loads all images from their files and resizes them to the correct size
  private void loadImages()
  {
    // Base background image
    baseBackgroundImage = loadImage("images/basebackground.png");
    baseBackgroundImage.resize(1200, 850); // Resize to fill the whole canvas

    // Conveyor belt image
    conveyorBeltImage = loadImage("images/conveyorbelt.png");
    conveyorBeltImage.resize(1200, 250); // Resize to fill bottom 250px of the canvas
  }


  // Get the current belt speed
  public BeltSpeed getBeltSpeed()
  {
    return this.beltSpeed;
  }

  // Get the belt speed value of the current speed
  public Integer getBeltSpeedValue()
  {
    BeltSpeed currentSpeed = this.getBeltSpeed();
    return this.getBeltSpeedValue(currentSpeed);
  }

  // Get the belt speed value of the provided speed. Value is how many pixels it should move every frame
  public Integer getBeltSpeedValue(BeltSpeed currentSpeed)
  {
    Integer speed;

    switch(currentSpeed) {
    case SLOW: // 3px
      speed = 3;
      break;

    case FAST: // 10px
      speed = 10;
      break;

    case OFF: // 0px
    default:
      speed = 0;
    }

    return speed;
  }

  // Set the belt speed
  public void setBeltSpeed(BeltSpeed newSpeed)
  {
    this.beltSpeed = newSpeed;
  }


  public Boolean getShouldRender()
  {
    return true;
  }

  public void render()
  {
    // Render base background
    this.renderBaseBackground();

    // Render conveyor belt
    this.renderConveyorBelt();
  }


  // Renders the base background image. The ingredient trays and ingredients inside of those trays, as well as the store background.
  private void renderBaseBackground()
  {
    // Render base background image
    image(baseBackgroundImage, 0, 0);
  }

  // Renders the moving conveyor belt. Two of the same images giving the endless belt effect
  private void renderConveyorBelt()
  {
    int yPos = height - conveyorBeltImage.height; // Canvas height minus image height will place the image at the very bottom of the canvas

    // We draw the converyor belt image twice, one behind the other, same Y position
    image(conveyorBeltImage, backgroundX, yPos);
    image(conveyorBeltImage, backgroundX + conveyorBeltImage.width, yPos);

    // Move X left using the current belt speed value
    backgroundX = backgroundX - this.getBeltSpeedValue();

    // If the current X position is at the end of the first image (off canvas)
    if (backgroundX == -conveyorBeltImage.width)
    {
      // Reset position back to 0 to give infinite loop illusion
      backgroundX = 0;
    }
  }
}
