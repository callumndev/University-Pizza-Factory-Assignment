// Forward reference game object so both setup() and draw() can access it
PizzaGame pizzaFactory;

// The setup() function is called once when the program starts
void setup()
{
  // Update window size to 1200x850
  size(1200, 850);

  // Init the game instance
  Boolean debug = false;
  pizzaFactory = new PizzaGame(debug);
}

// Called directly after setup() and continuously executes the lines of code contained inside its block until the program is stopped
void draw()
{
  background(pizzaFactory.backgroundColour);

  // Call game render loop
  pizzaFactory.render();
}
