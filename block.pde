class Block {
  // 変数用意
  int zanki;
  float x, y, w, h;
  boolean isL;

  // Blockの属性
  Block(int zanki_num, float b_x, float b_y, float b_w, float b_h, boolean isleft) {
    zanki = zanki_num;
    x = b_x;
    y = b_y;
    w = b_w;
    h = b_h;
    isL = isleft;
  }

  // Blockの表示
  void display() {
    if (zanki > 0) {
      if (isL) { // 左右で色を変える
        image(red_block_image, x, y, w, h);
      } else {
        image(blue_block_image, x, y, w, h);
      }
    }
  }

  // ボールとブロックの衝突判定 衝突していたらtrueを返す
  boolean hit_ball(Ball ball) {
    if (zanki > 0) { // ブロックが残っているなら
      if (circleHitBlockCheck(x, y, w, h, ball)) {
        zanki--;
        return true; // 衝突している
      }
    }
    return false;
  }

  // 残っていなかったら返す
  int remain() {
    if (zanki > 0) return 0;
    return 1;
  }
}