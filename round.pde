boolean end_round_flag = false;
void round() {
  // items表示など
  item();

  // count表示
  int count_time = game_time + countdown_before - ceil(now_millis / 1000);
  if (count_time > 5) { // 終わりに近づいたら目立たせる
    textSize(50);
    fill(0xff);
  } else {
    textSize(100);
    fill(0xff, 0, 0);
  }
  text(count_time, width/2, height/2);

  // balls移動、端の衝突判定、表示
  for (int i = 0; i < balls.length; i++) {
    balls[i].transition();
    balls[i].hit_screen_edge();
    balls[i].display();
  }
  // ボール同士の衝突判定
  ball_hit_ball(balls[0], balls[1]);
  ball_hit_ball(balls[1], balls[2]);
  ball_hit_ball(balls[2], balls[0]);

  // ブロックとボールの衝突判定とブロックの表示
  for (int i = 0; i < blocks.length; i++) {
    int end_round_count = 0;
    for (int j = 0; j < block_column; j++) {
      for (int k = 0; k < block_row; k++) {
        boolean hit_tf = false;
        for (int l = 0; l < balls.length; l++) {
          hit_tf = blocks[i][j][k].hit_ball(balls[l]);
          if (hit_tf) {bh_player.cue(0);} // 当たったら音リセット
        }
        blocks[i][j][k].display();
        end_round_count += blocks[i][j][k].remain();
      }
    }
    if (end_round_count == block_column * block_row) {
      end_round_flag = true;
    }
  }
  bh_player.play(); // 音流す リセットしてなければ流れない

  // バーの移動、位置修正、表示、ボールとの衝突判定
  for (int i = 0; i < bars.length; i++) {
    bars[i].transition();
    bars[i].adjust();
    bars[i].display();
    for (int j = 0; j < balls.length; ++j) {
      bars[i].daen_hit_ball(balls[j]);
    }
  }
}

// カウントが過ぎたら
void end_round() {
  for (int i = 0; i < blocks.length; i++) {
    for (int j = 0; j < block_column; j++) {
      for (int k = 0; k < block_row; k++) {
        remain_blocks[round_count][1-i] += blocks[i][j][k].remain(); // 当たったブロックを数える
      }
    }
  }
  // 差がある場合、ポイントを1加える
  if (remain_blocks[round_count][0] > remain_blocks[round_count][1]) {
    score_round[0] += 1;
  } else if (remain_blocks[round_count][0] < remain_blocks[round_count][1]) {
    score_round[1] += 1;
  }
  round_count++;
  scene = 4; // 画面遷移
}