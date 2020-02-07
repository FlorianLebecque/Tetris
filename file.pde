void loadSetup() {
  String[] list = loadStrings(dataPath("")+"/setup.txt");
  HIGHSCORE = Integer.parseInt(list[0]);
  is_sound = boolean(list[1]);
  is_zone = Integer.parseInt(list[2]);
  is_dark = boolean(list[3]);
}

void saveSetup() {
  String[] list = new String[4];
  list[0] = str(HIGHSCORE);
  list[1] = str(is_sound);
  list[2] = str(is_zone);
  list[3] = str(is_dark);
  saveStrings(dataPath("")+"/setup.txt", list);
}
