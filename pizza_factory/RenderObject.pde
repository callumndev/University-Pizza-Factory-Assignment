class RenderObject implements RenderObjectImpl
{
  protected PizzaGame game;
  protected Assets assets;
  protected TextUtils textUtils;
  protected GameUtils gameUtils;

  public RenderObject(PizzaGame game)
  {
    this.game = game;
    this.assets = game.assets;
    this.textUtils = game.textUtils;
    this.gameUtils = game.gameUtils;
  }

  public PizzaGame getGame()
  {
    return this.game;
  }

  // Default to always rendering
  public Boolean getShouldRender()
  {
    return true;
  }

  // Does not needs to be overriden
  public void style()
  {
  }

  // Needs to be overriden
  public void render()
  {
    throw new IllegalStateException("Method public void render() on class RenderObject needs to be overriden.");
  }
}
