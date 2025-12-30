# 互動式學習平台 - 專案結構文檔

## 📁 專案概述

這是一個互動式學習平台，用於創建和管理多個學習主題的知識點內容。平台支持多層級學習（初階、中階、高階），每個知識點可以展開查看詳細內容。

## 🏗️ 目錄結構

```
MyNotes/
├── index.html              # 首頁 - 主題入口
├── chapter.html            # 通用章節頁面（所有主題共用）
├── config.json             # 配置文件 - 定義所有主題和JSON路徑
├── smart-home.html         # 智能家居專用頁面（舊，可保留向後相容）
├── webpage.md              # 網頁標記（暫未使用）
└── smart-home/             # 智能家居主題資料夾
    ├── beginner.json       # 初階知識點
    ├── intermediate.json   # 中階知識點
    └── advanced.json       # 高階知識點
```

## 📋 核心檔案說明

### 1. **config.json** - 配置中心
**作用**: 定義所有學習主題及其JSON文件路徑

**結構範例**:
```json
{
  "topics": [
    {
      "id": "smart-home",
      "title": "智能家居",
      "icon": "🏠",
      "subtitle": "從基礎到進階，系統化學習智能家居技術",
      "description": "從基礎概念到系統開發，全方位學習智能家居技術",
      "levels": [
        {
          "id": "beginner",
          "order": 1,
          "jsonFile": "smart-home/beginner.json"
        },
        {
          "id": "intermediate",
          "order": 2,
          "jsonFile": "smart-home/intermediate.json"
        },
        {
          "id": "advanced",
          "order": 3,
          "jsonFile": "smart-home/advanced.json"
        }
      ]
    }
  ]
}
```

**擴展方式**: 添加新主題時，只需在`topics`陣列中新增一個對象

### 2. **index.html** - 首頁
**作用**: 學習平台的入口頁面

**功能**:
- 動態從`config.json`讀取所有主題
- 為每個主題生成卡片
- 點擊卡片進入對應章節（帶`?topic=xxx`參數）
- 預留Coming Soon位置供未來擴展

**路由**: 
- `chapter.html?topic=smart-home` → 進入智能家居主題

### 3. **chapter.html** - 通用章節頁面 ⭐ 重要
**作用**: 所有主題的內容展示頁面（共用同一個HTML）

**工作流程**:
1. 從URL獲取`topic`參數
2. 讀取`config.json`找到對應主題配置
3. 根據配置加載該主題的所有JSON文件
4. 動態渲染知識點卡片

**特性**:
- 小型可點擊卡片設計
- 點擊卡片可展開/收合詳細內容
- 按級別（初/中/高階）分組顯示
- 無展開按鈕，交互更簡潔

**URL範例**:
- `chapter.html?topic=smart-home` 加載智能家居
- 新主題只需改`topic`參數值

### 4. **smart-home.html** - 專用頁面（可選保留）
**作用**: 智能家居主題的舊專用頁面

**狀態**: 功能與`chapter.html`相同，保留用於向後相容性

**建議**: 可設置重定向到`chapter.html?topic=smart-home`

### 5. **知識點JSON文件結構**

#### 目錄組織
```
smart-home/
├── beginner.json       # 初階（級別1）
├── intermediate.json   # 中階（級別2）
└── advanced.json       # 高階（級別3）
```

#### JSON格式範例
```json
{
  "level": {
    "id": "beginner",
    "name": "初階",
    "emoji": "🟢",
    "description": "基礎概念與入門",
    "color": "#4caf50"
  },
  "knowledgePoints": [
    {
      "number": "01",
      "title": "知識點標題",
      "subtitle": "副標題/簡短描述",
      "sections": [
        {
          "heading": "章節標題",
          "content": "正文內容（可選）",
          "list": ["列表項1", "列表項2"],
          "subSections": [
            {
              "subHeading": "子章節標題",
              "content": "子章節內容",
              "list": ["子列表項1"]
            }
          ]
        }
      ]
    }
  ]
}
```

## 🚀 工作流程

### 查看現有主題
1. 打開 `index.html` → 主頁加載所有主題卡片
2. 點擊智能家居卡片 → 轉到 `chapter.html?topic=smart-home`
3. 頁面加載三個級別的知識點
4. 點擊卡片展開/收合內容

### 新增新主題的步驟

1. **創建主題資料夾**
   ```
   MyNotes/my-topic/
   ├── beginner.json
   ├── intermediate.json
   └── advanced.json
   ```

2. **更新config.json** - 添加新主題配置
   ```json
   {
     "id": "my-topic",
     "title": "我的主題",
     "icon": "📚",
     "subtitle": "主題描述",
     "description": "更詳細的描述",
     "levels": [
       {"id": "beginner", "order": 1, "jsonFile": "my-topic/beginner.json"},
       {"id": "intermediate", "order": 2, "jsonFile": "my-topic/intermediate.json"},
       {"id": "advanced", "order": 3, "jsonFile": "my-topic/advanced.json"}
     ]
   }
   ```

3. **填充JSON文件** - 按照上述格式組織知識點

4. **完成** - 首頁會自動顯示新主題卡片

## 🔄 數據流圖

```
index.html (首頁)
    ↓
config.json (讀取主題列表)
    ↓
生成卡片，帶topic參數
    ↓
chapter.html (通用章節頁面)
    ↓
根據topic參數，讀取config.json中的JSON路徑
    ↓
加載對應主題的JSON文件
    ├── smart-home/beginner.json
    ├── smart-home/intermediate.json
    └── smart-home/advanced.json
    ↓
渲染知識點卡片和內容
```

## 📝 知識點卡片特性

- **小型設計**: 縮小的卡片尺寸，更多內容一屏展示
- **點擊展開**: 點擊整個卡片即可展開詳細內容
- **無展開按鈕**: 交互更簡潔
- **Hover效果**: 提示卡片可點擊
- **分級顯示**: 按初/中/高階分組

## 🎨 樣式配置

### 主要顏色
- 初階: `#4caf50` 🟢 (綠)
- 中階: `#ff9800` 🟡 (橙)
- 高階: `#f44336` 🔴 (紅)

### 響應式設計
- 桌面: Grid布局自適應
- 手機: 單列顯示

## 🔧 維護建議

1. **config.json是單一真實來源** - 所有主題配置都在此
2. **chapter.html無需修改** - 新主題不需要新HTML
3. **JSON路徑必須正確** - 相對於根目錄的路徑
4. **測試新主題** - 確保JSON格式正確

## ❓ 常見問題

**Q: 如何改變知識點卡片的樣式？**
A: 修改`chapter.html`中的CSS部分，所有主題都會應用

**Q: 如何新增第四個級別？**
A: 在JSON中新增`level`條件，在`chapter.html`中保持相同渲染邏輯

**Q: 如何國際化支持多語言？**
A: 創建多個語言版本的`config.json`和JSON文件，或添加i18n邏輯

## 📞 技術棧

- **HTML5** - 頁面結構
- **CSS3** - 樣式和響應式設計
- **Vanilla JavaScript** - 動態內容加載和交互
- **JSON** - 數據存儲格式
- **無後端依賴** - 純前端靜態應用
