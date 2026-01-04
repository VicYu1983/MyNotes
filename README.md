# 智能家居學習平台

一個互動式的線上學習平台，涵蓋智能家居、物聯網和自動化相關知識。

## 📚 課程內容

本平台提供五個主題的學習資源，每個主題包含 50 道測驗題目，分為初級（Beginner）、中級（Intermediate）和進階（Advanced）三個難度級別。

### 主題列表

1. **智能家居（Smart Home）** 📱
   - 基本概念和智能設備
   - 家庭網路設置
   - 設備選擇和安裝指南
   - 共 50 題

2. **Home Assistant** 🏠
   - 开源自動化平台
   - 系統安裝和配置
   - 自動化規則編寫
   - 共 50 題

3. **家居改善（Home Improvement）** 🔧
   - 傳統家裝升級
   - 能源效率優化
   - 安全性增強
   - 共 50 題

4. **智能家居改善（Smart Home Improvement）** ✨
   - 智能化改造方案
   - 分階段實施計劃
   - 投資回報評估
   - 共 50 題

5. **Node-RED** ⚙️
   - 視覺化流程編程
   - 物聯網集成
   - 自動化邏輯設計
   - 共 50 題

## 🗂️ 文件結構

```
MyNotes/
├── README.md                          # 本文件
├── index.html                         # 主頁面
├── chapter.html                       # 測驗頁面
├── smart-home.html                    # 智能家居主題頁
├── config.json                        # 配置文件
├── PROJECT_STRUCTURE.md               # 項目結構文檔
│
├── home-assistant/                    # Home Assistant 主題
│   ├── beginner.json                  # 初級教學資源
│   ├── intermediate.json              # 中級教學資源
│   ├── advanced.json                  # 進階教學資源
│   └── question.json                  # 50 道測驗題（4 選 1）
│
├── smart-home/                        # 智能家居主題
│   ├── beginner.json
│   ├── intermediate.json
│   ├── advanced.json
│   └── question.json
│
├── home-improvement/                  # 家居改善主題
│   ├── beginner.json
│   ├── intermediate.json
│   ├── advanced.json
│   └── question.json
│
├── smart-home-improvement/            # 智能家居改善主題
│   ├── beginner.json
│   ├── intermediate.json
│   ├── advanced.json
│   └── question.json
│
└── node-red/                          # Node-RED 主題
    ├── beginner.json
    ├── intermediate.json
    ├── advanced.json
    └── question.json
```

## 📝 question.json 格式

所有測驗題目均採用統一的 JSON 格式：

```json
{
  "questions": [
    {
      "id": 1,
      "level": "beginner",
      "chapter": "01. 主題名稱",
      "question": "問題內容",
      "options": [
        "選項 1",
        "選項 2",
        "選項 3",
        "選項 4"
      ],
      "correctAnswer": 1,
      "explanation": "解釋說明"
    }
  ]
}
```

### 字段說明

| 字段 | 類型 | 說明 |
|------|------|------|
| `id` | number | 題目唯一識別符（1-50） |
| `level` | string | 難度級別：`beginner`、`intermediate`、`advanced` |
| `chapter` | string | 章節標題，格式：`XX. 標題名` |
| `question` | string | 問題文本 |
| `options` | array | 四個選項的字符串陣列 |
| `correctAnswer` | number | 正確答案索引（0-3） |
| `explanation` | string | 答案解釋 |

## 🚀 使用指南

### 1. 在線瀏覽

直接打開 `index.html` 或 `smart-home.html` 即可開始學習。

### 2. 選擇主題

在主頁上選擇要學習的主題，系統會自動加載相應的 50 道題目。

### 3. 開始測驗

- 點擊「開始測驗」按鈕
- 逐題答題，每題有 4 個選項
- 系統會實時計分，顯示正確率
- 完成後查看詳細的答案解釋

### 4. 進度追蹤

- 系統記錄答題進度
- 可查看各難度級別的得分
- 支援重新測驗以提升成績

## 🔧 技術棧

- **前端**：HTML5、CSS3、JavaScript（ES6+）
- **數據格式**：JSON
- **存儲**：本地 localStorage 或雲端存儲
- **兼容性**：Chrome、Firefox、Safari、Edge

## 📊 學習路徑

建議按以下順序學習：

1. **入門階段** → 從「智能家居」開始理解基本概念
2. **基礎階段** → 學習「Home Assistant」實踐自動化
3. **進階階段** → 研究「智能家居改善」的完整方案
4. **實踐階段** → 使用「Node-RED」設計自己的流程
5. **優化階段** → 深化「家居改善」的各個方面

## 💡 使用建議

- 💯 **目標設定**：每個主題的及格線為 70%（35/50 題）
- 📈 **循序漸進**：先完成 beginner 級別的教材，再進行測驗
- 🔄 **反復複習**：多次測驗相同主題以加深理解
- 📚 **跨主題學習**：不同主題間存在知識關聯，可相互補充
- 🛠️ **實踐應用**：邊學邊練，結合實際場景應用知識

## 📋 功能特性

✅ 50 道精心設計的題目（每個主題）  
✅ 三個難度級別循序漸進  
✅ 完整的答案解釋  
✅ 實時反饋和評分  
✅ 進度保存和跟蹤  
✅ 響應式設計，支持各種設備  
✅ 離線可用（基於本地存儲）  

## 🐛 已知問題與解決方案

### 問題：測驗資料載入失敗

**原因**：JSON 文件格式錯誤或選項數組不完整

**解決方案**：
- 確保每道題都有 4 個選項
- 檢查 JSON 語法，確保所有引號和括號正確配對
- 驗證 `correctAnswer` 的索引值在 0-3 範圍內

## 📞 技術支持

如遇問題或有改進建議，請檢查：

1. **數據完整性**：確認 JSON 文件中每個問題都有 4 個選項
2. **格式正確性**：使用 JSON 驗證工具檢查語法
3. **瀏覽器兼容性**：嘗試切換到最新版瀏覽器
4. **緩存問題**：清除瀏覽器緩存後重新加載

## � Docker 部署

本項目支援 Docker 容器化部署，快速一鍵部署到任何環境。

### 快速開始

```bash
# 使用 Docker Compose（推薦）
docker-compose up -d

# 訪問應用
# http://localhost:8080
```

詳細部署指南請查看 [DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)

## �🔐 隱私與數據

- 所有學習進度默認保存在本地瀏覽器
- 不收集用戶個人信息
- 支援導出學習記錄為 JSON 格式

## 📄 許可證

本項目用於教育目的，內容持續更新中。

## 🙏 致謝

感謝所有貢獻者的支持和反饋！

---

**最後更新**：2026 年 1 月 4 日  
**版本**：1.0.0

祝您學習愉快！ 🎓
