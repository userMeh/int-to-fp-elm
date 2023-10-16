// @ts-check
import * as drawlib from "./drawlib.js";

const stack = [
  drawlib.move(
    10,
    100,
    drawlib.group([
      drawlib.rotate(
        70,
        drawlib.move(50, 50, drawlib.rectangle(drawlib.darkYellow, 75, 50))
      ),
      drawlib.move(50, 50, drawlib.circle(drawlib.darkPurple, 5)),
    ])
  ),
];

const line = drawlib.rectangle(drawlib.darkBlue, 100, 2);

/**
 * @returns {Array<number>}
 * @param {number} start
 * @param {number} end
 */
function range(start, end) {
  const res = [];
  for (let i = start; i < end; ++i) {
    res.push(i);
  }
  return res;
}

const LINES_COUNT = 30;
const stack2 = range(0, LINES_COUNT).map((i) =>
  drawlib.rotate((i * 360) / LINES_COUNT, line)
);

function draw() {
  const canvas = document.getElementById("canvas");
  if (canvas.getContext) {
    const ctx = canvas.getContext("2d");

    drawlib.renderStack(stack2, ctx);

    // ctx.fillStyle = "rgb(200, 0, 0)";
    // ctx.fillRect(10, 10, 50, 50);

    // ctx.fillStyle = "rgba(0, 0, 200, 0.5)";
    // ctx.fillRect(30, 30, 50, 50);
  }
}
draw();
