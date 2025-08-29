import { ObservedArray } from '../mvvm/PageEntry'
import { MyBook, Tag } from './LazyForEachTestPage'

class MyViewModel {
  getBookInitData(): ObservedArray<MyBook> {
    return bookData
  }
}

const bookData: Array<MyBook> = [
  {
    id: '1',
    name: '史记',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '2',
    name: '资治通鉴',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '3',
    name: '围城',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '4',
    name: '狂人日志',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '5',
    name: '朝花夕拾',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '6',
    name: '西游记',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '7',
    name: '水浒传',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '8',
    name: '天龙八部',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '9',
    name: '射雕英雄传',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
  {
    id: '10',
    name: '红楼梦',
    isSelected: false,
    tag: {
      name:'小说',
      isCollected:false
    }
  },
]

let mViewModel = new MyViewModel()

export default mViewModel as MyViewModel