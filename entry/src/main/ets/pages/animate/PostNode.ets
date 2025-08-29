// PostNode.ets
// 跨容器迁移能力
import { UIContext } from '@ohos.arkui.UIContext';
import { NodeController, BuilderNode, FrameNode } from '@ohos.arkui.node';
import { curves } from '@kit.ArkUI';


class Data {
  item: string | null = null
  isExpand: Boolean | false = false
}


@Builder
function PostBuilder(data: Data) {
  // 跨容器迁移组件置于@Builder内
  Column() {
    Row() {
      Row()
        .backgroundColor(Color.Pink)
        .borderRadius(20)
        .width(80)
        .height(80)


      Column() {
        Text('点击展开 Item ' + data.item)
          .fontSize(20)
        Text('共享元素转场')
          .fontSize(12)
          .fontColor(0x909399)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ left: 10 })
      .height(80)
    }
    .width('90%')
    .height(100)
    // 展开后显示细节内容
    if (data.isExpand) {
      Row() {
        Text('展开态')
          .fontSize(28)
          .fontColor(0x909399)
          .textAlign(TextAlign.Center)
          .transition(TransitionEffect.OPACITY.animation({ curve: curves.springMotion(0.6, 0.9) }))
      }
      .width('90%')
      .justifyContent(FlexAlign.Center)
    }
  }
  .width('90%')
  .height('100%')
  .alignItems(HorizontalAlign.Center)
  .borderRadius(10)
  .margin({ top: 15 })
  .backgroundColor(Color.White)
  .shadow({
    radius: 20,
    color: 0x909399,
    offsetX: 20,
    offsetY: 10
  })
}


class __InternalValue__ {
  flag:boolean =false;
};


export class PostNode extends NodeController {
  private node: BuilderNode<Data[]> | null = null;
  private isRemove: __InternalValue__ = new __InternalValue__();
  private callback: Function | undefined = undefined
  private data: Data | null = null


  makeNode(uiContext: UIContext): FrameNode | null {
    if(this.isRemove.flag == true){
      return null;
    }
    if (this.node != null) {
      return this.node.getFrameNode();
    }


    return null;
  }


  init(uiContext: UIContext, id: string, isExpand: boolean) {
    if (this.node != null) {
      return;
    }
    // 创建节点，需要uiContext
    this.node = new BuilderNode(uiContext)
    // 创建离线组件
    this.data = { item: id, isExpand: isExpand }
    this.node.build(wrapBuilder<Data[]>(PostBuilder), this.data)
  }


  update(id: string, isExpand: boolean) {
    if (this.node !== null) {
      // 调用update进行更新。
      this.data = { item: id, isExpand: isExpand }
      this.node.update(this.data);
    }
  }


  setCallback(callback: Function | undefined) {
    this.callback = callback
  }


  callCallback() {
    if (this.callback != undefined) {
      this.callback();
    }
  }


  onRemove(){
    this.isRemove.flag = true;
    // 组件迁移出节点时触发重建
    this.rebuild();
    this.isRemove.flag = false;
  }
}


let gNodeMap: Map<string, PostNode | undefined> = new Map();


export const createPostNode =
  (uiContext: UIContext, id: string, isExpand: boolean): PostNode | undefined => {
    let node = new PostNode();
    node.init(uiContext, id, isExpand);
    gNodeMap.set(id, node);
    return node;
  }


export const getPostNode = (id: string): PostNode | undefined => {
  if (!gNodeMap.has(id)) {
    return undefined
  }
  return gNodeMap.get(id);
}


export const deleteNode = (id: string) => {
  gNodeMap.delete(id)
}