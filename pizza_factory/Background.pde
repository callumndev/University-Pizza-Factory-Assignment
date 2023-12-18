import java.util.Map;
import java.util.LinkedHashMap;

class Background extends RenderObject
{
  private PImage conveyorBeltImage;
  int bgX = 0;


  public Background(PizzaGame game)
  {
    super(game);

    conveyorBeltImage = loadImage("images/conveyorbelt.png");
    conveyorBeltImage.resize(1200, 250);
  }


  public Boolean getShouldRender()
  {
    return true;
  }

  public void render()
  {
    // Render conveyor belt
    this.conveyorBelt();
  }

  private void conveyorBelt()
  {
    //image(conveyorBeltImage, 10, 10);

    image(conveyorBeltImage, bgX, height - conveyorBeltImage.height); //draw image to fill the canvas
    //draw image again off the right of the canvas
    image(conveyorBeltImage, bgX+conveyorBeltImage.width, height - conveyorBeltImage.height);
    bgX = bgX- 2;
    if (bgX == -conveyorBeltImage.width) //if first image completely off the canvas
    {
      bgX=0; //reset back to initial value background
    }
  }
}
