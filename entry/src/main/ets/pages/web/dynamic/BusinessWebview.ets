

import { BuilderData } from "./DynamicComponent";

@Builder
function WebBuilder(data: BuilderData) {
  // 此处组件可根据业务需要自行扩展
  Web({ src: data.url, controller: data.controller })
    .cacheMode(CacheMode.Default)
}

export const businessWebview = wrapBuilder<BuilderData[]>(WebBuilder);