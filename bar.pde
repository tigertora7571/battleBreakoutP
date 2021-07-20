class Bar {
  // 変数用意
  float x, y, w, h, v;
  boolean up, down;
  boolean isL;

  // Barの属性
  Bar (float bar_x, float bar_y, float bar_w, float bar_h, float bar_v, boolean up_key, boolean down_key, boolean isleft) {
    x = bar_x;
    y = bar_y;
    w = bar_w;
    h = bar_h;
    v = bar_v;
    up = up_key;
    down = down_key;
    isL = isleft;
  }

  // Barの移動
  void transition() {
    if (up) { // 上を押したら上に移動
      y -= v;
    }
    if (down) {
      y += v; // 下を押したら下に移動
    }
  }

  // Barと画面端の接触判定と修正
  void adjust() {
    if (y < h/2) { // 画面上
      y = h/2;
    }
    if (y > height - h/2) { // 画面下
      y = height - h/2;
    }
  }

  // Barの表示
  void display() {
    if (isL) { // 左
      fill(0xec, 0x55, 0x80);
      arc(x, y, w, h, -HALF_PI, HALF_PI, CHORD);
    } else { // 右
      fill(0x17, 0x9b, 0xff);
      arc(x, y, w, h, HALF_PI, PI+HALF_PI, CHORD);
    }
  }

  // Barとボールが接触したか判定
  void daen_hit_ball(Ball ball) {
    if (ball.frame > 0) { // 数フレーム衝突判定を行わない。
      ball.frame--;
    } else {
      boolean daen_check, daen_check2;
      // Barの楕円部分と平らな部分のどちらの判定を行うかの条件式 疑似的な楕円と接触判定を行う 左と右で異なる
      if (isL) {
        daen_check = (ball.x > x) && (ball.x <= x + w/2);
        daen_check2 = (ball.x >= x - ball.b_size/2) && (ball.x <= x) && (ball.y >= y - h/2) && (ball.y <= y + h/2);
      } else {
        daen_check = (ball.x >= x - w/2) && (ball.x < x);
        daen_check2 = (ball.x >= x) && (ball.x <= x + ball.b_size/2) && (ball.y >= y - h/2) && (ball.y <= y + h/2);
      }
      if (daen_check) { // 楕円側の判定
        float shoten_y = sqrt(pow(h/2 + ball.b_size/2, 2) - pow(w/2 + ball.b_size/2, 2)); // 楕円の中心から楕円の焦点までの距離
        float shoten_dist = dist(x, y - shoten_y, ball.x, ball.y) + dist(x, y + shoten_y, ball.x, ball.y); // ボールと焦点間の距離
        // ボールと焦点間の距離が楕円の長軸以下であれば接触している
        if((shoten_dist <= h + ball.b_size) && (shoten_dist > shoten_y * 2)) {
          // ここからボールの反射角とx方向y方向の速度を求める
          float da_y = ball.y - y;
          float da_x = sqrt(pow((w + ball.b_size)/2, 2) * (1 - pow(2 * da_y / (h + ball.b_size), 2)));
          if (!isL) da_x = -da_x;
          float katamuki = pow((w + ball.b_size) / (h + ball.b_size), 2) * da_y / da_x;
          float moto_tan = atan(ball.v_y / ball.v_x);
          float now_tan = 2 * atan(katamuki) - PI - moto_tan;
          ball.v_x = ball.v * cos(now_tan);
          ball.v_y = ball.v * sin(now_tan);
          // ここまで
          if (isL) { // 左であれば符号逆
            ball.v_x = -ball.v_x;
            ball.v_y = -ball.v_y;
          }
          ball.frame = 3; // 3フレームだけ衝突判定を行わない
        }
      }
      if (daen_check2) { // 平らな方の判定
        ball.v_x = -ball.v_x;
        ball.frame = 3;
      }
    }
  }
}