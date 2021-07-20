int now_millis;
int countdown_before = 3;
// ゲーム始まる前のカウントダウン
void countdown() {
  now_millis = millis() - countdown_start; // countdown_startからのミリ秒数
  if (now_millis >= countdown_before*1000) { // ゲーム前のカウントダウンが終了したか判定
    scene = 3; // 画面遷移
  } else {
    textAlign(CENTER, CENTER);
    textSize(128);
    fill(0);
    text(countdown_before - ceil(now_millis / 1000), width/2, height/2); // カウントダウン表示
    // 操作説明
    textSize(32);
    text("WSキーで操作", width/4, 50);
    text("IKキーで操作", width/4*3, 50);
  }
  // Ball表示
  for (int i = 0; i < balls.length; i++) {
    balls[i].display();
  }
  // Block表示
  for (int i = 0; i < blocks.length; i++) {
    for (int j = 0; j < block_column; j++) {
      for (int k = 0; k < block_row; k++) {
        blocks[i][j][k].display();
      }
    }
  }
  // Bar表示＆動かせる
  for (int i = 0; i < bars.length; i++) {
    bars[i].transition();
    bars[i].adjust();
    bars[i].display();
  }
}

// ゲーム画面
void game() {
  // init bg
  image(bg_game, 0, 0, width, height);
  now_millis = millis() - countdown_start; // 今の経過時間
  if (now_millis <= game_time*1000 + countdown_before*1000 && !end_round_flag) {
    round(); // ゲーム画面描画
  } else {
    end_round(); // ラウンド終了
  }
}