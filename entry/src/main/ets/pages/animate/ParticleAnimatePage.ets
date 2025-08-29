import { RouterUtil } from "@ohos/common"

@Entry({ routeName: 'ParticleAnimatePage' })
@Component
export struct ParticleAnimatePage {
  static startPage() {
    RouterUtil.pushNamedRouteSingle('ParticleAnimatePage')
  }

  @State emitterProperties: Array<EmitterProperty> = [
    {
      index: 0,
      emitRate: 100,
      position: { x: 60, y: 80 },
      size: { width: 200, height: 200 }
    }
  ]

  build() {
    Stack() {

      Particle({
        particles: [
          {
            emitter: {
              particle: {
                type: ParticleType.POINT, //粒子类型
                config: {
                  radius: 5//粒子半径
                },
                count: 100,//粒子数量
                lifetime: 300, // 粒子生命周期，单位ms
                lifetimeRange: 100 // 粒子生命周期取值范围，单位ms
              },
              emitRate: 10, // 每秒发射粒子数
              position: [0, 0],
              shape: ParticleEmitterShape.RECTANGLE // 发射器形状
            },
            color: {
              range: ['rgb(39, 135, 217)', 'rgb(0, 74, 175)'],
              distributionType: DistributionType.GAUSSIAN // 初始颜色随机值分布
            },
            scale: {
              range: [0.0, 0.0],
              updater: {
                type: ParticleUpdater.CURVE,
                config: [
                  {
                    from: 0.0,
                    to: 0.5,
                    startMillis: 0,
                    endMillis: 3000,
                    curve: Curve.EaseIn
                  }
                ]
              }
            },
            acceleration: { //加速度的配置，从大小和方向两个维度变化，speed表示加速度大小，angle表示加速度方向
              speed: {
                range: [3, 9],
                updater: {
                  type: ParticleUpdater.RANDOM,
                  config: [1, 20]
                }
              },
              angle: {
                range: [90, 90]
              }
            }
          }
        ]
      })
        .width(300)
        .height(300)
        .emitter(this.emitterProperties)
        .disturbanceFields([{
          strength: 10,
          shape: DisturbanceFieldShape.RECT,
          size: { width: 100, height: 100 },
          position: { x: 100, y: 100 },
          feather: 15,
          noiseScale: 10,
          noiseFrequency: 15,
          noiseAmplitude: 5
        }])
    }.width('100%')
    .height('100%')
  }
}