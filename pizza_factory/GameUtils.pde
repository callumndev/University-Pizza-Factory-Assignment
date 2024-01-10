class GameUtils
{
  protected PizzaGame game;

  public GameUtils(PizzaGame game)
  {
    this.game = game;
  }


  // Returns the process uptime in milliseconds
  public Long getUptimeMS()
  {
    return System.currentTimeMillis() - this.game.processStartedAt;
  }


  // Returns true if the point is inside the specified rectangle bounds, false if not
  public Boolean isPointInsideRect(Float pointX, Float pointY, Float rectX, Float rectY, Float rectWidth, Float rectHeight)
  {
    return
      pointX >= rectX && // PointX is to the right of the left edge, or on it
      pointX <= rectX + rectWidth && // PointX is not past the right edge or is on it
      pointY >= rectY && // PointY is below the top edge, or on it
      pointY <= rectY + rectHeight; // PointY is not past the bottom edge or is on it
  }

  // Returns true if the point is inside the specified ellipse bounds, false if not
  public Boolean isPointInsideEllipse(Float pointX, Float pointY, Float ellipseX, Float ellipseY, Float ellipseWidth, Float ellipseHeight)
  {
    // Calculate normalised point from pointX, pointY to ellipseX, ellipseY
    Float normalisedX = (pointX - ellipseX) / (ellipseWidth / 2);
    Float normalisedY = (pointY - ellipseY) / (ellipseHeight / 2);

    return (
      // Squared
      Math.pow(normalisedX, 2) + Math.pow(normalisedY, 2)
      ) <= 1; // If squared normalisedX + normalisedY is less than or equal to 1 then the point is inside the ellipse
  }
}
