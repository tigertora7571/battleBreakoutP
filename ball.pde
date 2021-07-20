class Ball {
  // 変数用意
  boolean exist;
  float x, y, b_size, v_x, v_y, v;
  int frame;

  // Ballの属性
  Ball(boolean exist_, float pos_x, float pos_y, float ball_size, float vel_x, float vel_y, float vel, int frame_count) {
    exist = exist_;
    x = pos_x;
    y = pos_y;
    b_size = ball_size;
    v_x = vel_x;
    v_y = vel_y;
    v = vel;
    frame = frame_count;
  }

  // Ballの表示
  void display() {
    if (exist) {
      fill(0x44);
      circle(x, y, b_size);
    }
  }

  // Ballの移動
  void transition() {
    if (exist) {
      x += v_x;
      y += v_y;
    }
  }

  // Ballの画面端の当たり判定
  void hit_screen_edge() {
    if (exist) {
      if (x < b_size/2) {
        v_x = abs(v_x);
      }
      if (x > width - b_size/2) {
        v_x = -abs(v_x);
      }
      if (y < b_size/2) {
        v_y = abs(v_y);
      }
      if (y > height - b_size/2) {
        v_y = -abs(v_y);
      }
    }
  }
}