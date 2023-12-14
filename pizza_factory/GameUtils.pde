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
}
