// BallとBallが衝突したか判定
void ball_hit_ball(Ball ball1, Ball ball2) {
  if (ball1.frame == 0 && ball2.frame == 0) {
    if (ball1.exist && ball2.exist) {
      float center_dist = dist(ball1.x, ball1.y, ball2.x, ball2.y); // ボールとボールの中心間距離
      if (center_dist <= (ball1.b_size + ball2.b_size)/2) { // 衝突判定
        float change[] = {ball1.v_x, ball1.v_y}; // 速度入れ替え
        ball1.v_x = ball2.v_x;
        ball1.v_y = ball2.v_y;
        ball2.v_x = change[0];
        ball2.v_y = change[1];
        ball1.frame = 2;
        ball2.frame = 2;
      }
    }
  }
}