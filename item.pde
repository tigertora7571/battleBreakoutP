boolean new_ball_flag = true; // ボール3つまで
// アイテムを確率で生成、衝突判定、表示を行う
void item() {
  int item_rand = int(random(item_ratio));
  if (item_rand < 4) { // 確率でアイテム表示
    if (!(item_rand == 3 && !new_ball_flag)) {
      if (items[item_rand][0] == 0 || (item_rand == 3 && new_ball_flag)) {
        items[item_rand][0] = 1; // 存在フラグ
        items[item_rand][1] = random(570, 970);; // x座標
        items[item_rand][2] = random(840); // y座標
      }
    }
  }
  for (int i = 0; i < items.length; i++) {
    if (items[i][0] > 0) { // アイテム存在判定
      image(items_img[i], items[i][1], items[i][2]); // アイテム描画
      for (int j = 0; j < balls.length; j++) {
        if (balls[j].exist) { // ボール存在判定
          float item_ball_dist = dist(balls[j].x, balls[j].y, items[i][1] + 30, items[i][2] + 30); // ボールとアイテムとの中心間距離
          if (item_ball_dist <= balls[j].b_size/2 + 30) { // ボールとアイテムの衝突判定
            if (i == 0) { // ボールを速くする
              balls[j].v_x = balls[j].v_x / balls[j].v * (balls[j].v + 2);
              balls[j].v_y = balls[j].v_y / balls[j].v * (balls[j].v + 2);
              balls[j].v += 2;
              items[i][0] = 0;
            } else if (i == 1) { // ボールを大きくする
              balls[j].b_size += random(5, 8);
              items[i][0] = 0;
            } else if (i == 2) { // ボールを小さくする
              if (balls[j].b_size - 6 > 0) {
                balls[j].b_size -= random(4, 6);
                items[i][0] = 0;
              }
            } else if (i == 3) { // ボールが2つならば3つに増やす
              balls[2] = new Ball(true, items[i][1] - 20, items[i][2], ball_size, ball_v/sqrt(2), -ball_v/sqrt(2), ball_v, 0);
              new_ball_flag = false;
              items[i][0] = 0;
            }
          }
        }
      }
    }
  }
}