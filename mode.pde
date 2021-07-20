int mode_list_int[][] = {
  {8, 10, 12},        // ボール速度
  {90, 120, 150},     // バーの縦の長さ
  {8000, 4000, 2000}, // アイテムの確率
  {30, 60, 90},       // 制限時間
  {3, 5, 7}           // ラウンド数
};
String mode_str[] = {"ボール速度", "バーの縦の長さ", "アイテム出現確率", "制限時間", "ラウンド数"}; // 左側文字表示
String options_str[][] = {
  {"小", "中", "大"},
  {"小", "中", "大"},
  {"小", "中", "大"},
  {"30", "60", "90"},
  {"3", "5", "7"}
}; // 選択肢
int save_options[] = {1, 1, 1, 0, 0}; // 初期設定
int cursor = 0;
boolean delay_flag = false;
int saved_flag = 0;

void mode() {
  // モード選択文字表示
  fill(0x22);
  textSize(64);
  textAlign(CENTER, TOP);
  text("モード選択", width/2, 50);
  textSize(40);
  float text_box_h = textAscent() + textDescent() + 5; // テキストの背景のrectの高さ
  for (int i = 0; i < mode_str.length; i++) {
    // 5つのオプション 文字表示
    fill(0x22);
    textAlign(RIGHT, TOP);
    text(mode_str[i], 750, i*100+200);
    textAlign(CENTER, TOP);
    // 大中小表示
    for (int j = 0; j < options_str[i].length; j++) {
      fill(152, 179, 217, 0xff);
      stroke(0);
      rect(800+j*100, i*100+200, 100, text_box_h);
      fill(0xff);
      text(options_str[i][j], 850+j*100, i*100+200);
    }
    // 選択されているものの色変更
    fill(0xff);
    stroke(0);
    rect(800+save_options[i]*100, i*100+200, 100, text_box_h);
    fill(0);
    text(options_str[i][save_options[i]], 850+save_options[i]*100, i*100+200);
  }
  // カーソル位置の色変更
  fill(0);
  stroke(0xff);
  rect(800+save_options[cursor]*100, cursor*100+200, 100, text_box_h);
  fill(0xff);
  text(options_str[cursor][save_options[cursor]], 850+save_options[cursor]*100, cursor*100+200);
  if (delay_flag) { // 遅延を入れて一気に上下左右に移動しないように
    delay(150);
    delay_flag = false;
  } else { // キーを押したら動く
    if (keyPressed) {
      if (keyCode == UP && cursor > 0) { // 上
        cursor--;
        delay_flag = true;
      }
      if (keyCode == DOWN && cursor < 4) { // 下
        cursor++;
        delay_flag = true;
      }
      if (keyCode == LEFT && save_options[cursor] > 0) { // 左
        save_options[cursor]--;
        delay_flag = true;
      }
      if (keyCode == RIGHT && save_options[cursor] < 2) { // 右
        save_options[cursor]++;
        delay_flag = true;
      }
    }
  }

  textSize(40);
  textAlign(CENTER, TOP);
  fill(0x22);
  text("Press R to Return to the Top", width/2, 800);
  // オプション保存
  ball_v = mode_list_int[0][save_options[0]];
  bar_velocity = mode_list_int[0][save_options[0]] - 1;
  bar_height = mode_list_int[1][save_options[1]];
  item_ratio = mode_list_int[2][save_options[2]];
  game_time = mode_list_int[3][save_options[3]];
  round = mode_list_int[4][save_options[4]];
  // TOPに戻る
  if (keyPressed && (key == 'r' || key == 'R')) {
    scene = 0;
  }
}