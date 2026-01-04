# 互動式學習平台 - 專案結構文檔

## 📁 專案概述

這是一個互動式學習平台，整合了知識點內容和測驗功能。平台支持多層級學習（初階、中階、高階），每個主題包含知識點展示和 50 道測驗題目，支援實時評分和答案解釋。支援 Docker 容器化部署。

## 🏗️ 目錄結構

```
MyNotes/
├── README.md               # 平台使用指南
├── DOCKER_DEPLOYMENT.md    # Docker 部署指南 ⭐ 新增
├── index.html              # 首頁 - 主題入口
├── chapter.html            # 通用章節頁面 + 測驗頁面（所有主題共用）
├── config.json             # 配置文件 - 定義所有主題和JSON路徑
├── smart-home.html         # 智能家居專用頁面（舊，可保留向後相容）
├── webpage.md              # 網頁標記（暫未使用）
├── PROJECT_STRUCTURE.md    # 本文檔
├── Dockerfile              # Docker 鏡像構建配置 ⭐ 新增
├── docker-compose.yml      # Docker Compose 編排配置 ⭐ 新增
├── nginx.conf              # Nginx 服務器配置 ⭐ 新增
├── .dockerignore           # Docker 構建排除文件 ⭐ 新增
│
├── home-assistant/         # Home Assistant 主題資料夾
│   ├── beginner.json       # 初階知識點
│   ├── intermediate.json   # 中階知識點
│   ├── advanced.json       # 高階知識點
│   └── question.json       # ⭐ 50 道測驗題目
│
├── smart-home/             # 智能家居主題資料夾
│   ├── beginner.json       # 初階知識點
│   ├── intermediate.json   # 中階知識點
│   ├── advanced.json       # 高階知識點
│   └── question.json       # ⭐ 50 道測驗題目
│
├── home-improvement/       # 家居改善主題資料夾
│   ├── beginner.json       # 初階知識點
│   ├── intermediate.json   # 中階知識點
│   ├── advanced.json       # 高階知識點
│   └── question.json       # ⭐ 50 道測驗題目
│
├── smart-home-improvement/ # 智能家居改善主題資料夾
│   ├── beginner.json       # 初階知識點
│   ├── intermediate.json   # 中階知識點
│   ├── advanced.json       # 高階知識點
│   └── question.json       # ⭐ 50 道測驗題目
│
└── node-red/               # Node-RED 主題資料夾
    ├── beginner.json       # 初階知識點
    ├── intermediate.json   # 中階知識點
    ├── advanced.json       # 高階知識點
    └── question.json       # ⭐ 50 道測驗題目
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

### 3. **chapter.html** - 通用章節 + 測驗頁面 ⭐ 重要
**作用**: 所有主題的內容展示和測驗頁面（共用同一個HTML）

**工作流程**:
1. 從URL獲取`topic`參數
2. 讀取`config.json`找到對應主題配置
3. 根據配置加載該主題的所有JSON文件（包括 question.json）
4. 動態渲染知識點卡片或測驗題目

**頁面模式**:
- **知識點模式**: 展示分級的知識點卡片（初/中/高階）
- **測驗模式**: 加載 question.json 的 50 道題目，實時評分

**特性**:
- 小型可點擊卡片設計（知識點模式）
- 點擊卡片可展開/收合詳細內容
- 按級別（初/中/高階）分組顯示
- 完整的測驗功能：單選題、計分、答案解釋、進度追蹤

**URL範例**:
- `chapter.html?topic=smart-home` 加載智能家居知識點
- `chapter.html?topic=smart-home&quiz=true` 進入測驗模式

### 4. **question.json** - 測驗題庫 ⭐ 新增
**作用**: 每個主題的 50 道測驗題目

**文件位置**: 每個主題資料夾下
- `smart-home/question.json`
- `home-assistant/question.json`
- `home-improvement/question.json`
- `smart-home-improvement/question.json`
- `node-red/question.json`

**JSON格式**:
```json
{
  "questions": [
    {
      "id": 1,
      "level": "beginner",
      "chapter": "01. 章節標題",
      "question": "問題內容",
      "options": [
        "選項 1",
        "選項 2",
        "選項 3",
        "選項 4"
      ],
      "correctAnswer": 1,
      "explanation": "詳細的答案解釋"
    },
    {
      "id": 2,
      "level": "intermediate",
      "chapter": "02. 下一章節",
      "question": "另一個問題",
      "options": ["A", "B", "C", "D"],
      "correctAnswer": 2,
      "explanation": "答案解釋..."
    }
  ]
}
```

**欄位說明**:
| 欄位 | 類型 | 說明 |
|------|------|------|
| `id` | number | 題目 ID（1-50） |
| `level` | string | 難度：`beginner`、`intermediate`、`advanced` |
| `chapter` | string | 章節標籤，格式：`XX. 標題名` |
| `question` | string | 問題文本 |
| `options` | array | 4 個選項的字符串陣列 |
| `correctAnswer` | number | 正確答案索引（0-3） |
| `explanation` | string | 答案解釋 |

### 5. **smart-home.html** - 專用頁面（可選保留）
**作用**: 智能家居主題的舊專用頁面

**狀態**: 功能與`chapter.html`相同，保留用於向後相容性

**建議**: 可設置重定向到`chapter.html?topic=smart-home`

### 6. **知識點JSON文件結構**

#### 目錄組織
```
smart-home/
├── beginner.json       # 初階（級別1）
├── intermediate.json   # 中階（級別2）
├── advanced.json       # 高階（級別3）
└── question.json       # 50 道測驗題目
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
2. 點擊主題卡片 → 轉到 `chapter.html?topic=xxx`
3. 頁面加載三個級別的知識點
4. 點擊卡片展開/收合內容

### 開始測驗
1. 在章節頁面點擊「開始測驗」按鈕
2. 或直接訪問 `chapter.html?topic=xxx&quiz=true`
3. 加載該主題的 question.json
4. 逐題答題，實時計分
5. 完成後查看得分和詳細解釋

### 新增新主題的步驟

1. **創建主題資料夾**
   ```
   MyNotes/my-topic/
   ├── beginner.json
   ├── intermediate.json
   ├── advanced.json
   └── question.json
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

3. **填充JSON文件** 
   - 按照上述格式組織知識點（beginner、intermediate、advanced.json）
   - 創建 question.json，包含 50 道測驗題目

4. **完成** - 首頁會自動顯示新主題卡片，測驗功能也自動可用

## 🔄 數據流圖

```
index.html (首頁)
    ↓
config.json (讀取主題列表)
    ↓
生成卡片，帶topic參數
    ↓
chapter.html (通用章節/測驗頁面)
    ├─── 知識點模式：
    │    根據topic參數，讀取config.json中的JSON路徑
    │    ├── smart-home/beginner.json
    │    ├── smart-home/intermediate.json
    │    └── smart-home/advanced.json
    │    ↓
    │    渲染知識點卡片和內容
    │
    └─── 測驗模式（quiz=true）：
         加載 smart-home/question.json
         ↓
         渲染 50 道測驗題目
         ↓
         實時評分和答案解釋
```

## 📝 知識點卡片特性

- **小型設計**: 縮小的卡片尺寸，更多內容一屏展示
- **點擊展開**: 點擊整個卡片即可展開詳細內容
- **無展開按鈕**: 交互更簡潔
- **Hover效果**: 提示卡片可點擊
- **分級顯示**: 按初/中/高階分組

## 📝 測驗功能特性

- **50 道題目**: 每個主題精心設計的題目
- **多難度級別**: 初級、中級、進階循序漸進
- **實時計分**: 即時反饋答題結果
- **完整解釋**: 每道題都有詳細的答案解釋
- **進度追蹤**: 記錄答題進度和成績
- **章節標籤**: 題目按章節分類，便於複習特定知識點

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
4. **測試新主題** - 確保 JSON 格式正確
5. **確認 question.json 完整性** - 每題需有 4 個選項，correctAnswer 索引 0-3

## ❓ 常見問題

**Q: 測驗資料載入失敗怎麼辦？**
A: 檢查 question.json：
- 確保每道題都有 4 個選項（不能少於 4 個）
- JSON 語法正確，所有引號括號配對
- `correctAnswer` 值在 0-3 範圍內

**Q: 如何改變卡片或測驗的樣式？**
A: 修改 `chapter.html` 中的 CSS 部分，所有主題都會應用

**Q: 如何新增新的難度級別？**
A: 在各主題的 question.json 中新增 `level` 值，在 chapter.html 中添加對應的渲染邏輯

**Q: 如何國際化支持多語言？**
A: 創建多個語言版本的 `config.json` 和 JSON 文件，或添加 i18n 邏輯

## 📞 技術棧

- **HTML5** - 頁面結構
- **CSS3** - 樣式和響應式設計
- **Vanilla JavaScript** - 動態內容加載和交互
- **JSON** - 數據存儲格式
- **Docker** - 容器化部署
- **Nginx** - Web 服務器
- **無後端依賴** - 純前端靜態應用

## 🐳 Docker 部署

本項目已配置完整的 Docker 支援：

### 快速部署
```bash
docker-compose up -d
```

### 配置文件
- `Dockerfile` - 使用 nginx:alpine 基礎鏡像
- `docker-compose.yml` - 本地開發編排配置
- `nginx.conf` - 優化的 Nginx 配置（Gzip、緩存、安全頭）
- `.dockerignore` - 排除不必要文件

詳細部署指南請查看 [DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)
