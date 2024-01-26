// @ts-nocheck
import * as color from './color.js';
import * as drawlib from './drawlib.js';

/**
 * @throws {string}
 * @returns {CanvasRenderingContext2D}
 * @param {string} id
 */
function get2DContextById(id) {
  const canvas = document.getElementById(id);
  if (canvas === null) {
    throw 'No html element with id `canvas` found';
  }
  if (!(canvas instanceof HTMLCanvasElement)) {
    throw 'The selected element is not a canvas';
  }
  if (canvas.getContext) {
    const ctx = canvas.getContext('2d');
    if (ctx) {
      return ctx;
    } else {
      throw 'Error when getting the context';
    }
  } else {
    throw '`getContext` is not a property of the element. Please use a modern browser.';
  }
}

/**
 * @param {Color} color
 * @returns {drawlib.Shape}
 */
function floof(color) {
  return drawlib.group([
    drawlib.move(0, -40, drawlib.circle(color, 60)),
    drawlib.move(40, 20, drawlib.circle(color, 60)),
    drawlib.move(80, 30, drawlib.circle(color, 60)),
    drawlib.move(60, -20, drawlib.circle(color, 60)),
    drawlib.move(40, -80, drawlib.circle(color, 60)),
    drawlib.move(100, -80, drawlib.circle(color, 60)),
    drawlib.move(160, -70, drawlib.circle(color, 60)),
    drawlib.move(200, -40, drawlib.circle(color, 60)),
    drawlib.move(160, 20, drawlib.circle(color, 60)),
  ]);
}

const feet = drawlib.group([
  drawlib.rectangle(color.darkGrey, 20, 40),
  drawlib.move(0, 40, drawlib.rectangle(color.darkGrey, 20, 40)),
]);

const head = drawlib.group([
  drawlib.circle(color.darkGrey, 50),
  // ears
  drawlib.move(
    25,
    -20,
    drawlib.polygon(color.darkGrey, [
      { x: 0, y: 0 },
      { x: 20, y: -7 },
      { x: 40, y: 53 },
      { x: 20, y: 60 },
    ]),
  ),
  drawlib.move(
    -50,
    -20,
    drawlib.polygon(color.darkGrey, [
      { x: 0, y: 0 },
      { x: 20, y: 7 },
      { x: 0, y: 67 },
      { x: -20, y: 60 },
    ]),
  ),
  // mouth
  drawlib.move(
    0,
    20,
    drawlib.polygon(color.black, [
      { x: 0, y: 0 },
      { x: 10, y: 10 },
      { x: -10, y: 10 },
    ]),
  ),
  // nose
  drawlib.move(0, 5, drawlib.rectangle(color.black, 5, 10)),
  // eyes
  drawlib.move(-15, -10, drawlib.circle(color.black, 5)),
  drawlib.move(15, -10, drawlib.circle(color.black, 5)),
]);

const sheep = drawlib.group([
  // back feets
  drawlib.move(0, -40, feet),
  drawlib.move(140, -40, feet),
  // wool
  drawlib.move(0, -100, floof(color.lightGrey)),
  // front feets
  drawlib.move(40, -20, feet),
  drawlib.move(180, -20, feet),
  drawlib.move(-20, -150, head),
]);

const tree = drawlib.group([
  drawlib.move(100, 100, drawlib.rectangle(color.brown, 80, 300)),
  floof(color.green),
]);

const image = drawlib.group([
  // grass
  drawlib.move(0, 200, drawlib.rectangle(color.lightGreen, 800, 500)),
  drawlib.move(-50, -260, tree),
  drawlib.move(-400, -200, tree),
  drawlib.move(200, -160, tree),
  drawlib.move(-250, 150, sheep),
  drawlib.move(100, 220, sheep),
]);

function main() {
  const context = get2DContextById('canvas');
  drawlib.renderCentered(image, context);
}
main();
