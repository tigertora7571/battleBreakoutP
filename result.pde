void result() {
  // ゲームスコア表示
  textAlign(CENTER, CENTER);
  fill(0x22);
  textSize(128);
  text(score_round[0] + " - " + score_round[1], width/2, height/(round+3));
  textSize(64);
  // ラウンドごとのスコア表示
  for (int i = 0; i < round_count; i++) {
    text(remain_blocks[i][0] + " - " + remain_blocks[i][1], width/2, height/(round+5)*(i+3));
  }
  // Block表示
  for (int i = 0; i < blocks.length; i++) {
    for (int j = 0; j < block_column; j++) {
      for (int k = 0; k < block_row; k++) {
        blocks[i][j][k].display();
      }
    }
  }
  // Bar表示
  for (int i = 0; i < bars.length; i++) {
    bars[i].display();
  }
  boolean end_flag = false; // ゲームが終了かどうかのフラグ
  if (round_count == round) { // 最終ラウンドを終えたか
    int ii; // 0か255かにするやつ
    // ゲームスコア比較
    if (score_round[0] != score_round[1]) { // 差がついているか
      if (score_round[0] > score_round[1]) {
        ii = 0;
      } else {
        ii = 1;
      }
    } else { // ゲームスコア同じだったら
      int left_total = 0;
      int right_total = 0;
      // 合計する
      for (int i = 0; i < round; i++) {
        left_total += remain_blocks[i][0];
        right_total += remain_blocks[i][1];
      }
      if (left_total != right_total) { // 差がついているか
        if (left_total > right_total) {
          ii = 0;
        } else {
          ii = 1;
        }
      } else {
        ii = -1; // 差が同じフラグ
      }
    }
    if (ii != -1) { // 同じじゃなかったら
      fill((1-ii)*255, 0, ii*255); // 色を変えて
      text("Win!", width/3*(ii+1), height/(round+8)); // 勝ったほうに表示
    } else {
      fill(0x73, 0x4e, 0x30);
      text("Draw", width/2, height/(round+8)); // 同じだったら中央にDraw表示
    }
  } else {
    // 最終ラウンドでなくても残りラウンド数より勝ち数の差が大きかったら終了
    int sa = score_round[1] - score_round[0];
    if (abs(sa) > round - round_count) {
      if (sa < 0) { // left
        fill(255, 0, 0);
        text("Win!", width/3, height/(round+8));
      } else { // right
        fill(0, 0, 255);
        text("Win!", width/3*2, height/(round+8));
      }
      end_flag = true;
    }
  }

  // 文字表示
  fill(0x22);
  textSize(48);
  text("Press Space to Continue", width/2, height/(round+3)*(round+2));
  if (keyPressed && key == ' ') {
    if (round_count == round || end_flag) { // 終わったらタイトル
      scene = 0;
    } else { // 続くならラウンドを初期化してカウントダウン再びスタート
      init_round();
      scene = 2;
    }
  }
}