class PizzaGame
{
  private final String name = "Pizza Factory";
  private final String credits = "Callum N (https://github.com/callumndev)";

  private Boolean enableDebug = false;
  private Long processStartedAt = System.currentTimeMillis();

  private final Assets assets = new Assets();
  public final TextUtils textUtils = new TextUtils();
  public final GameUtils gameUtils = new GameUtils(this);

  private final ArrayList<RenderObjectImpl> activeRenderObjects = new ArrayList<>(); // List of all the objects that should be actively sent to the render loop
  private final IngredientHandling ingredients = new IngredientHandling(this);
  private final Background background = new Background(this);
  private final Pizza pizza = new Pizza(this);

  public final color backgroundColour = color(255, 255, 255, 255);
  public final Integer maxMistakes = 3; // How many mistakes the user can make before the game ends


  public PizzaGame(Boolean debug)
  {
    this.enableDebug = debug;

    init();
  }

  public PizzaGame()
  {
    init();
  }


  public void init()
  {
    // Set the title at the top of the sketch window
    surface.setTitle(String.format("%s by %s", this.name, this.credits));

    // Add background object
    this.activeRenderObjects.add(background);

    // Add pizza object
    this.activeRenderObjects.add(pizza);

    // Handles everything for dragging, colliding etc, for ingredients
    this.activeRenderObjects.add(ingredients);

    // Add window debug info if we are in debug mode
    if (this.enableDebug)
      this.activeRenderObjects.add(new DebugOverlay(this));
  }


  // Game render loop
  public void render()
  {
    for (RenderObjectImpl obj : this.activeRenderObjects) {
      // Get should render
      Boolean shouldRender = obj.getShouldRender();

      // Render object
      if (shouldRender)
      {
        // Start a new style
        pushStyle();

        // Apply style
        obj.style();

        // Render object
        obj.render();

        // Restore original style
        popStyle();
      }
    }
  }
}
