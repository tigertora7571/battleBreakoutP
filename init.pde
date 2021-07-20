// ゲーム初期化
void init_game() {
  remain_blocks = new int[round][2];
  round_count = 0;
  score_round[0] = 0;
  score_round[1] = 0;
}

// ラウンド初期化
void init_round() {
  // init bar
  bars[0] = new Bar(400, 450, 50, bar_height, bar_velocity, false, false, true);
  bars[1] = new Bar(1200, 450, 50, bar_height, bar_velocity, false, false, false);
  for (int i = 0; i < items.length; ++i) {
    for (int j = 0; j < items[i].length; ++j) {
      items[i][j] = 0;
    }
  }

  // init ball
  balls[0] = new Ball(true, 700, 100, ball_size, -ball_v/sqrt(2), ball_v/sqrt(2), ball_v, 0);
  balls[1] = new Ball(true, 900, 800, ball_size, ball_v/sqrt(2), -ball_v/sqrt(2), ball_v, 0);
  balls[2] = new Ball(false, 900, 800, ball_size, ball_v/sqrt(2), -ball_v/sqrt(2), ball_v, 0);

  // init item
  new_ball_flag = false;
  for (int i = 0; i < items.length; i++) {
    for (int j = 0; j < items[i].length; j++) {
      items[i][j] = 0;
    }
  }

  // init block
  b_h = (height - (block_row + 1) * block_sukima) / block_row;
  for (int i = 0; i < block_column; i++) {
    for (int j = 0; j < block_row; j++) {
      blocks[0][i][j] = new Block(1, block_sukima * (i + 1) + 50 * i, b_h * j + block_sukima * (j + 1), b_w, b_h, true);
    }
  }
  for (int i = 0; i < block_column; i++) {
    for (int j = 0; j < block_row; j++) {
      blocks[1][i][j] = new Block(1, 1600 - (50 + block_sukima) * (i + 1), b_h * j + block_sukima * (j + 1), b_w, b_h, false);
    }
  }
  // init countdown
  countdown_start = millis();
  new_ball_flag = true;
  end_round_flag = false;
}