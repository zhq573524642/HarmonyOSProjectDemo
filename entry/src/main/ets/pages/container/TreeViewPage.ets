import {
  CallbackParam,
  NodeParam,
  TreeController,
  TreeListener,
  TreeListenerManager,
  TreeListenType,
  TreeView
} from '@ohos.arkui.advanced.TreeView'

@Entry
@Component
struct TreeViewPage {
  private treeController: TreeController = new TreeController()
  private treeListener: TreeListener = TreeListenerManager.getInstance().getTreeListener()
  @State clickNodeId: number = 0

  aboutToDisappear(): void {
    this.treeListener.off(TreeListenType.NODE_CLICK, undefined)
    this.treeListener.off(TreeListenType.NODE_ADD, undefined)
    this.treeListener.off(TreeListenType.NODE_DELETE, undefined)
    this.treeListener.off(TreeListenType.NODE_MODIFY, undefined)
    this.treeListener.off(TreeListenType.NODE_MOVE, undefined)
  }

  aboutToAppear(): void {
    this.treeListener.on(TreeListenType.NODE_CLICK, (callback: CallbackParam) => {
      this.clickNodeId = callback.currentNodeId
    })
    this.treeListener.on(TreeListenType.NODE_ADD, (callback: CallbackParam) => {
      this.clickNodeId = callback.currentNodeId
    })
    this.treeListener.on(TreeListenType.NODE_DELETE, (callback: CallbackParam) => {
      this.clickNodeId = callback.currentNodeId
    })
    this.treeListener.on(TreeListenType.NODE_MODIFY, (callback: CallbackParam) => {
      this.clickNodeId = callback.currentNodeId
    })
    this.treeListener.on(TreeListenType.NODE_MOVE, (callback: CallbackParam) => {
      this.clickNodeId = callback.currentNodeId
    })

    let normalIcon: Resource = $r('app.media.ic_star_bg')
    let selectIcon: Resource = $r('app.media.ic_star_forward')
    let editIcon: Resource = $r('app.media.ic_star_second')

    let node1:NodeParam={
      parentNodeId: -1,
      currentNodeId: 1,
      isFolder: true,
      primaryTitle: '水果',
      secondaryTitle: '3'
    }
    let  node1_1:NodeParam={
      parentNodeId: 1,
      currentNodeId: 11,
      isFolder: false,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '苹果',
    }
    let  node1_2:NodeParam={
      parentNodeId: 1,
      currentNodeId: 12,
      isFolder: false,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '香蕉',
    }
    let  node1_3:NodeParam={
      parentNodeId: 1,
      currentNodeId: 13,
      isFolder: false,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '葡萄',
    }
    let  node2:NodeParam={
      parentNodeId: -1,
      currentNodeId: 2,
      isFolder: true,
      primaryTitle: '蔬菜',
      secondaryTitle: '蔬菜的分类'
    }
    let  node2_1:NodeParam={
      parentNodeId: 2,
      currentNodeId: 21,
      isFolder: true,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '根茎类',
      secondaryTitle:'3'
    }
    let  node2_1_1:NodeParam={
      parentNodeId: 21,
      currentNodeId: 211,
      isFolder: false,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '土豆'
    }
    let  node2_1_2:NodeParam={
      parentNodeId: 21,
      currentNodeId: 212,
      isFolder: false,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '红薯'
    }
    let  node2_1_3:NodeParam={
      parentNodeId: 21,
      currentNodeId: 213,
      isFolder: false,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '紫薯'
    }
    let  node2_2:NodeParam={
      parentNodeId: 2,
      currentNodeId: 22,
      isFolder: false,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '叶菜类'
    }
    let  node2_3:NodeParam={
      parentNodeId: 2,
      currentNodeId: 23,
      isFolder: false,
      icon: normalIcon,
      selectedIcon: selectIcon,
      editIcon: editIcon,
      primaryTitle: '菌菇类'
    }
    //结构
    //1
    //1-1，1-2，1-3
    //2
    //2-1
    //2-1-1，2-1-2，2-1-3
    //2-2，2-3
    this.treeController
      .addNode(node1)
      .addNode(node1_1)
      .addNode(node1_2)
      .addNode(node1_3)
      .addNode(node2)
      .addNode(node2_1)
      .addNode(node2_1_1)
      .addNode(node2_1_2)
      .addNode(node2_1_3)
      .addNode(node2_2)
      .addNode(node2_3)
      .buildDone()
    // this.treeController.refreshNode(-1, '主标题', '副标题')

  }

  build() {
    Column({ space: 15 }) {
      TreeView({
        treeController: this.treeController
      })
      Button('Add（1-4）')
        .onClick(() => {
          let node1_4:NodeParam={
            parentNodeId: 1,
            currentNodeId: 14,
            isFolder: false,
            primaryTitle: '西瓜'}
          this.treeController.addNode(node1_4).buildDone()
          this.treeController.refreshNode(1,'4','1')
        })
      Button('Modify')
        .onClick(() => {
          this.treeController.modifyNode()
        })
      Button('Remove')
        .onClick(() => {
          this.treeController.removeNode()
        })
    }
  }
}