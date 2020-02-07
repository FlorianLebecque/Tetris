class button {

  float x, y, w, h;
  String text="";

  PImage texture;

  button() {
  }

  boolean Is_click() {
    if ((mouseX < x+w)&&(mouseX>x)) {
      if ((mouseY<y+h)&&(mouseY>y)) {
        return true;
      }
    }
    return false;
  }

  void show() {
    fill(147, 154, 175);
    if (Is_click()) {
      fill(107, 114, 135);
    }
    rect(x, y, w, h);
    if (texture!=null) {
      image(texture, x, y, w, h);
    }
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(height/24);
    text(text, x, y, w, h);
  }
}
