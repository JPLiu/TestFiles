// 配置参数
const MAX_RETRIES = 3;     // 最大重试次数
const RETRY_DELAY = 2000;  // 重试间隔（毫秒）

// 存储重试记录的Map
const retryCounts = new Map();

chrome.webNavigation.onErrorOccurred.addListener((details) => {
  // 仅处理主框架的失败
  if (details.frameId !== 0) return;
  
  // 排除用户取消的情况
  if (details.error === "net::ERR_ABORTED") return;

  const tabId = details.tabId;
  
  // 获取当前重试次数
  const currentCount = retryCounts.get(tabId) || 0;
  
  if (currentCount < MAX_RETRIES) {
    // 增加重试计数
    retryCounts.set(tabId, currentCount + 1);
    
    // 延迟后重试
    setTimeout(() => {
      chrome.tabs.reload(tabId, {}, () => {
        // 如果重载失败（例如标签页已关闭）
        if (chrome.runtime.lastError) {
          retryCounts.delete(tabId);
        }
      });
    }, RETRY_DELAY);
  } else {
    // 超过最大重试次数后重置
    retryCounts.delete(tabId);
  }
});

// 标签页关闭时清理记录
chrome.tabs.onRemoved.addListener((tabId) => {
  retryCounts.delete(tabId);
});
