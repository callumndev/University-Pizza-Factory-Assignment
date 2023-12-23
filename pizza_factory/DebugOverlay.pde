import java.util.Map;
import java.util.LinkedHashMap;

class DebugOverlay extends RenderObject
{
  private color debugTextOutlineColour = color(94, 144, 57, 255);
  private color debugTextColour = color(118, 185, 0, 255);
  private Integer debugTextSize = 20;

  LinkedHashMap<String, String> debugInfo = new LinkedHashMap<String, String>();


  public DebugOverlay(PizzaGame game)
  {
    super(game);
  }


  public Boolean getShouldRender()
  {
    // Processing docs advise frameRate value won't be valid until after 5-10 frames.
    return frameCount >= 10 && this.game.enableDebug == true;
  }

  public void style()
  {
    // Set text colour
    fill(this.debugTextColour);

    // Set text size
    textSize(this.debugTextSize);
  }

  public void render()
  {
    // Clear debugInfo map
    this.debugInfo.clear();


    this.debugInfo.put("Display", String.format("%sx%s", displayWidth, displayHeight)); // Add display resolution
    this.debugInfo.put("Window", String.format("%sx%s", width, height)); // Add window resolution
    this.debugInfo.put("Focused", Boolean.toString(focused)); // Add window focused

    this.debugInfo.put("Frame", Integer.toString(frameCount)); // Add frame number
    this.debugInfo.put("FPS", Integer.toString(Math.round(frameRate))); // Add Frames Per Second (FPS) counter

    this.debugInfo.put("Uptime", String.format("%sms", this.gameUtils.getUptimeMS())); // Add process uptime in milliseconds

    this.debugInfo.put("Cursor", String.format("%s, %S", mouseX, mouseY)); // Add cursor position


    // Render info inside of debugInfo
    this.renderDebugInfo();
  }

  // Renders all of the debug info inside of the debugInfo map
  private void renderDebugInfo()
  {
    // Keep track of current debug info index
    Integer debugInfoIndex = 1;

    // Iterate through debugInfo map
    for (Map.Entry<String, String> debugInfoEntry : this.debugInfo.entrySet())
    {
      // Get the debug info
      String infoName = debugInfoEntry.getKey();
      String infoValue = debugInfoEntry.getValue();

      // Calculate text
      String debugText = String.format("%s: %s", infoName, infoValue);
      Float debugTextWidth = textWidth(debugText);

      // Draw text
      Integer padding = 5;
      Float x = width - debugTextWidth; // Width minus the text width will place it at the very far right of the window
      Float y = this.textUtils.getTextHeight() * debugInfoIndex; // Very top of window relative to the text height + accounting for above (debugInfoIndex) rows of other text
      this.textUtils.drawTextWithOutline(debugText, x - padding, y - padding, this.debugTextOutlineColour);

      // Increment debugInfoIndex
      debugInfoIndex++;
    }
  }
}
