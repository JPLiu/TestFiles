// ==UserScript==
// @name         B站动态页优化
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  优化B站动态页，移除指定元素并调整宽度
// @author       DeepSeek
// @match        https://t.bilibili.com/*
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    // 等待页面加载完成
    window.addEventListener('load', function () {
        setTimeout(optimizePage, 1000);
        // 移除指定元素
        removeElement('.bili-dyn-live-users'); // 移除直播用户栏
        removeElement('.right'); // 移除右侧栏

        // 调整动态主页内容区宽度
        const mainElement = document.querySelector('.bili-dyn-home--member > main:nth-child(2)');
        if (mainElement) {
            mainElement.style.width = '65%';
            mainElement.style.setProperty('width', '65%', 'important');
        }
    });

    // 移除指定元素
    function removeElement(selector) {
        const elements = document.querySelectorAll(selector);
        elements.forEach(element => element.remove());
    }
})();
