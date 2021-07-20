// 円と四角の衝突判定
boolean circleHitBlockCheck(float bl_x, float bl_y, float bl_w, float bl_h, Ball ball) {
  if ((ball.x > bl_x - ball.b_size/2) && (ball.x < bl_x + bl_w + ball.b_size/2) && (ball.y > bl_y) && (ball.y < bl_y + bl_h)) {
    ball.v_x = -ball.v_x; // x方向衝突
  } else if ((ball.x > bl_x) && (ball.x < bl_x + bl_w) && (ball.y > bl_y - ball.b_size/2) && (ball.y < bl_y + bl_h + ball.b_size/2)){
    ball.v_y = -ball.v_y; // y方向衝突
  } else if(dist(bl_x, bl_y, ball.x, ball.y) <= ball.b_size/2) {
    ball.v_x = -abs(ball.v_x); // 角衝突
    ball.v_y = -abs(ball.v_y);
  } else if(dist(bl_x + bl_w, bl_y, ball.x, ball.y) <= ball.b_size/2) {
    ball.v_x = abs(ball.v_x); // 角衝突
    ball.v_y = -abs(ball.v_y);
  } else if(dist(bl_x, bl_y + bl_h, ball.x, ball.y) <= ball.b_size/2) {
    ball.v_x = -abs(ball.v_x); // 角衝突
    ball.v_y = abs(ball.v_y);
  } else if(dist(bl_x + bl_w, bl_y + bl_h, ball.x, ball.y) <= ball.b_size/2) {
    ball.v_x = abs(ball.v_x); // 角衝突
    ball.v_y = abs(ball.v_y);
  } else {
    return false;
  }
  return true;
}