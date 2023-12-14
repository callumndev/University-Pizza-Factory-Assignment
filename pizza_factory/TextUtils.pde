class TextUtils
{
  // Returns the current text font height
  public Float getTextHeight()
  {
    return textAscent() + textDescent();
  }

  // Draws text with an outline
  public void drawTextWithOutline(String text, Float x, Float y, color outlineColour) {
    // Start a new style
    pushStyle();

    // Apply outline colour
    fill(outlineColour);

    // Draw outline
    // out
    for (int outlineX = -1; outlineX < 2; outlineX++) {
      text(text, x+outlineX, y);
      text(text, x, y+outlineX);
    }

    // Restore original style
    popStyle();

    // Draw inner text
    text(text, x, y);
  }
}
