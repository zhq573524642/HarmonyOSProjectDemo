export class Point {
  x: number
  y: number

  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }

  plus(rhs: Point): Point {
    return new Point(this.x + rhs.x, this.y + rhs.y)
  }

  subtract(rhs: Point): Point {
    return new Point(this.x - rhs.x, this.y - rhs.y)
  }

  multiply(scale: number): Point {
    return new Point(this.x * scale, this.y * scale)
  }

  equals(rhs: Point): boolean {
    return this.x === rhs.x && this.y === rhs.y
  }
}

export class PointVector extends Array<Point> implements AnimatableArithmetic<PointVector> {
  constructor(value: Array<Point>) {
    super();
    value.forEach(p => this.push(p))
  }
  plus(rhs: PointVector): PointVector {
    let result = new PointVector([])
    const len = Math.min(this.length, rhs.length)
    for (let i = 0; i < len; i++) {
      result.push((this as Array<Point>)[i].plus((rhs as Array<Point>)[i]))
    }
    return result
  }
  subtract(rhs: PointVector): PointVector {
    let result = new PointVector([])
    const len = Math.min(this.length, rhs.length)
    for (let i = 0; i < len; i++) {
      result.push((this as Array<Point>)[i].subtract((rhs as Array<Point>)[i]))
    }
    return result
  }
  multiply(scale: number): PointVector {
    let result = new PointVector([])
    for (let i = 0; i < this.length; i++) {
      result.push((this as Array<Point>)[i].multiply(scale))
    }
    return result
  }
  equals(rhs: PointVector): boolean {
    if (this.length != rhs.length) {
      return false
    }
    for (let i = 0; i < this.length; i++) {
      if (!(this as Array<Point>)[i].equals((rhs as Array<Point>)[i])) {
        return false
      }
    }
    return true
  }
  get(): Array<Object[]> {
    let result: Array<Object[]> = []
    this.forEach(p => result.push([p.x, p.y]))
    return result
  }
}