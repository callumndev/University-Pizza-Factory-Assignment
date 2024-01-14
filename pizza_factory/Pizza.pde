class Pizza extends RenderObject
{
  private Integer xPos;
  private Integer yPos;


  public Pizza(PizzaGame game)
  {
    super(game);
    this.resetPosition();
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
      // Reset position to the right
      this.resetPosition();
    }
  }


  private void resetPosition()
  {
    this.xPos = width;
    this.yPos = (height - this.assets.gameConveyorBelt.height) + ((this.assets.gameConveyorBelt.height / 2) - (this.assets.toppingDoughRolled.height / 2));
  }
}
