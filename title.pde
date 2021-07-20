// タイトル画面
void title() {
  // ゲーム名表示
  textAlign(CENTER, TOP);
  textSize(60);
  fill(0x22);
  text("ブロック対戦ファイトバトル", width/2, height/4);
  textSize(40);
  text("上下キーで選択、Enterで実行", width/2, height - 60);
  float text_box_h = textAscent() + textDescent() + 5; // テキストの背景のrectの高さ
  if (keyPressed) {
    if (key == ENTER || key == RETURN) {
      if (title_color == 0xff) { // ゲームスタートへ遷移
        init_game();
        init_round();
        scene = 2; // GAME
        return;
      } else if (title_color == 0) { // モード選択へ遷移
        scene = 1; // MODE
        return;
      }
    } else {
      if (keyCode == UP) { // 選択
        title_color = 0xff;
      } else if (keyCode == DOWN) {
        title_color = 0;
      }
    }
    // 発表用
    if (key == 'q' || key == 'Q') game_time = 10;
  }
  // STARTボタンと背景
  stroke(0, title_color);
  fill(0, title_color);
  rect(500+4, height*5/8+4, 600, text_box_h);
  stroke(title_color);
  fill(152, 179, 217, 0xff);
  rect(500, height*5/8, 600, text_box_h);
  fill(0, title_color);
  text("START", width/2+2, height*5/8+2);
  fill(0xff, 0xff);
  text("START", width/2, height*5/8);
  // モード選択ボタンと背景
  stroke(0, 0xff - title_color);
  fill(0, 0xff - title_color);
  rect(500+4, height*3/4+4, 600, text_box_h);
  stroke(0xff - title_color);
  fill(152, 179, 217, 0xff);
  rect(500, height*3/4, 600, text_box_h);
  fill(0, 0xff - title_color);
  text("モード選択", width/2+2, height*3/4+2);
  fill(0xff, 0xff);
  text("モード選択", width/2, height*3/4);
}